#!/usr/bin/env python3
import subprocess


if __name__ == "__main__":
    find_path = "muxueqz/about.me"
    try:
        client = subprocess.check_output(
            [
                "pass",
                "show",
                find_path,
            ],
            timeout=1,
        )
    except (subprocess.CalledProcessError, subprocess.TimeoutExpired):
        subprocess.check_output(
            [
                "xterm",
                "-e",
                'pass show "%s"' % find_path,
            ]
        )
        client = subprocess.check_output(
            [
                "pass",
                "show",
                find_path,
            ]
        )
