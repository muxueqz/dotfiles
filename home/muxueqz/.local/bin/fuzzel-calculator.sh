#!/usr/bin/env sh

# Define the variable that holds the last result
LAST=""

# Function to evaluate using Lua
lua_eval() {
	lua - "$1" <<'EOF'
local expr = arg[1]

local allowed_env = {
	math = math
}

local f, err = load("return " .. expr, "expr", "t", allowed_env)

if not f then
	io.stderr:write(err .. "\n")
	os.exit(1)
end

local ok, result = pcall(f)
if not ok then
	io.stderr:write(result .. "\n")
	os.exit(1)
end

local s = tostring(result)
s = s:gsub("(%.%d-)0+$", "%1")
s = s:gsub("%.$", "")
print(s)
EOF
}

# Loop
while true; do
	[ -z "$LAST" ] && SPACE=" "
	NEXT="$(fuzzel -l 0 --dmenu -p "${LAST}${SPACE}")"

	[ -z "$NEXT" ] && exit 1
	[ "$NEXT" = "y" ] && wl-copy "$LAST" && exit 0

	EXPR="$LAST$NEXT"
	LAST="$(lua_eval "$EXPR")"
done
