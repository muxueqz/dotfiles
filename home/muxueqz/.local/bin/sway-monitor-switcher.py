#!/usr/bin/env python3
import subprocess
import json
import sys


def get_outputs():
    # 获取swaymsg输出的显示器列表
    output = subprocess.check_output(["swaymsg", "-t", "get_outputs"]).decode("utf-8")
    outputs = json.loads(output)
    return [output["name"] for output in outputs]


def toggle_output(output_name):
    # 切换指定的显示器
    subprocess.run(["sway", "output", output_name, "toggle"])


def main():
    # 获取显示器列表
    output_names = get_outputs()

    if not output_names:
        print("No outputs found.")
        sys.exit(1)

    # 使用rofi显示选择菜单
    cmd = (
        "rofi -dmenu -p 'Select output to toggle:' -lines 5 -no-case-sensitive -show {}"
    )
    cmd = cmd.format(" ".join(output_names))
    process = subprocess.Popen(
        cmd,
        shell=True,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    output, error = process.communicate(input="\n".join(output_names).encode("utf-8"))

    if output:
        selected_output = output.decode("utf-8").strip()
        if selected_output:
            toggle_output(selected_output)
            print(f"Toggling output: {selected_output}")
        else:
            print("No output selected.")
    else:
        print("Error:", error.decode("utf-8"))


if __name__ == "__main__":
    main()
