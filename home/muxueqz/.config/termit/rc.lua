-- Example file with lots of options.
-- You can test with with this command:
-- cd ./etc && ../src/termit --init ../doc/rc.lua.example

colormaps = require("termit.colormaps")
utils = require("termit.utils")

defaults = {}
-- defaults.windowTitle = 'Termit'
defaults.startMaximized = true
defaults.hideTitlebarWhenMaximized = true
defaults.allowChangingTitle = true
-- defaults.tabName = 'Terminal'
defaults.encoding = "UTF-8"
defaults.wordCharExceptions = "- .,_/"
-- defaults.font = 'Terminus 12'
-- defaults.font = 'WenQuanYi Micro Hei Mono 12'
defaults.font = "文泉驿等宽微米黑 14"

-- 文泉驿等宽微米黑,WenQuanYi Micro Hei Mono
--defaults.foregroundColor = 'gray'
defaults.foregroundColor = "white"
defaults.backgroundColor = "black"
defaults.showScrollbar = false
-- defaults.hideSingleTab = false
defaults.hideSingleTab = true
defaults.hideTabbar = false
-- defaults.showBorder = true
defaults.hideMenubar = true
defaults.fillTabbar = true
defaults.scrollbackLines = 4096
defaults.setStatusbar = function(tabInd)
	tab = tabs[tabInd]
	if tab then
		return tab.encoding .. "  Bksp: " .. tab.backspaceBinding .. "  Del: " .. tab.deleteBinding
	end
	return ""
end
-- defaults.colormap = colormaps.delicate
muxueqz_color = {
	"#000000",
	"#CD0000",
	"#00CD00",
	"#CDCD00",
	"#8686e6",
	"#CD00CD",
	"#00CDCD",
	"#E5E5E5",
	"#4D4D4D",
	"#ff0000",
	"#00ff00",
	"#00ffff",
	"#0000ff",
	"#ff00ff",
	"#00ffff",
	"#ffffff",
}
-- defaults.colormap = colormaps.bright
defaults.colormap = muxueqz_color
defaults.matches = {
	["http[^ ]+"] = function(url)
		print("Matching url: " .. url)
	end,
}
setOptions(defaults)

-- bindKey('Ctrl-Page_Up', prevTab)
-- bindKey('Ctrl-Page_Down', nextTab)
-- bindKey('Ctrl-F', findDlg)
-- bindKey('Ctrl-2', function () print('Hello2!') end)
-- bindKey('Ctrl-3', function () print('Hello3!') end)
bindKey('Ctrl-t', nil) -- remove previous binding
--
-- -- don't close tab with Ctrl-w, use CtrlShift-w
-- bindKey('Ctrl-w', nil)
-- bindKey('CtrlShift-w', closeTab)
bindKey('CtrlShift-c', copy)
bindKey('CtrlShift-v', paste)
--
setKbPolicy("keycode")

--
userMenu = {}
table.insert(userMenu, { name = "Close tab", action = closeTab })
table.insert(userMenu, {
	name = "New tab name",
	action = function()
		setTabTitle("New tab name")
	end,
})

table.insert(userMenu, { name = "Reconfigure", action = reconfigure, accel = "Ctrl-r" })
table.insert(userMenu, {
	name = "Selection",
	action = function()
		print(selection())
	end,
})
table.insert(userMenu, {
	name = "dumpAllRows",
	action = function()
		forEachRow(print)
	end,
})
table.insert(userMenu, {
	name = "dumpVisibleRowsToFile",
	action = function()
		utils.dumpToFile(forEachVisibleRow, "/tmp/termit.dump")
	end,
})
table.insert(userMenu, { name = "findNext", action = findNext, accel = "Alt-n" })
table.insert(userMenu, { name = "findPrev", action = findPrev, accel = "Alt-p" })
table.insert(userMenu, {
	name = "new colormap",
	action = function()
		setColormap(colormaps.mikado)
	end,
})
table.insert(userMenu, {
	name = "toggle menubar",
	action = function()
		toggleMenubar()
	end,
})
table.insert(userMenu, {
	name = "toggle tabbar",
	action = function()
		toggleTabbar()
	end,
})

mi = {}
mi.name = "Get tab info"
mi.action = function()
	tab = tabs[currentTabIndex()]
	if tab then
		utils.printTable(tab, "  ")
	end
end
table.insert(userMenu, mi)

function round(float)
	return math.floor(float + 0.5)
end

function changeTabFontSize(delta)
	tab = tabs[currentTabIndex()]
	fontSize = round(tab.fontSize)
	setTabFont(string.sub(tab.font, 1, string.find(tab.font, "%d+$") - 1) .. (fontSize + delta))
end

table.insert(userMenu, {
	name = "Increase font size",
	action = function()
		changeTabFontSize(1)
	end,
})
table.insert(userMenu, {
	name = "Decrease font size",
	action = function()
		changeTabFontSize(-1)
	end,
})
table.insert(userMenu, {
	name = "feed example",
	action = function()
		feed("example")
	end,
})
table.insert(userMenu, {
	name = "feedChild example",
	action = function()
		feedChild("date\n")
	end,
})
table.insert(userMenu, {
	name = "move tab left",
	action = function()
		setTabPos(currentTabIndex() - 1)
	end,
})
table.insert(userMenu, {
	name = "move tab right",
	action = function()
		setTabPos(currentTabIndex() + 1)
	end,
})
table.insert(userMenu, { name = "User quit", action = quit })

addMenu(userMenu, "User menu")
addPopupMenu(userMenu, "User menu")

addMenu(utils.encMenu(), "Encodings")
addPopupMenu(utils.encMenu(), "Encodings")
