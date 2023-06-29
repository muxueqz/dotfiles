#!/usr/bin/env python
import sys
import json

focused_workspace = ""


def extract_nodes_iterative(workspace):
    """Extracts all windows from a sway workspace json object"""
    all_nodes = []

    floating_nodes = workspace.get("floating_nodes")

    for floating_node in floating_nodes:
        floating_node["workspace"] = workspace["num"]
        all_nodes.append(floating_node)

    nodes = workspace.get("nodes")

    for node in nodes:
        # Leaf node
        if len(node.get("nodes")) == 0:
            node["workspace"] = workspace["num"]
            if node.get("focused"):
                global focused_workspace
                focused_workspace = workspace.get("id")
            all_nodes.append(node)
        # Nested node, handled iterative
        else:
            for inner_node in node.get("nodes"):
                inner_node["workspace"] = workspace["num"]
                nodes.append(inner_node)

    return all_nodes


def get_windows(only_workspace=False):
    """Returns a list of all json window objects"""
    data = json.load(sys.stdin)

    # Select outputs that are active
    workspace_windows = {}
    for output in data["nodes"]:
        # The scratchpad (under __i3) is not supported
        if output.get("name") != "__i3" and output.get("type") == "output":
            workspaces = output.get("nodes")
            for w in workspaces:
                for workspace in w.get("nodes"):
                    if workspace.get("type") == "workspace":
                        workspace_id = workspace.get("id")
                        windows = workspace_windows.setdefault(workspace_id, [])
                        windows += extract_nodes_iterative(workspace)
    windows = []
    for k, v in workspace_windows.items():
        if only_workspace and k != focused_workspace:
            continue
        windows.extend(v)
    return windows


if __name__ == "__main__":
    only_workspace = sys.argv[1] != "list_all_windows"
    r = get_windows(only_workspace)

    if sys.argv[1] in ("list_current_workspace_windows", "list_all_windows"):
        for window in r:
            print(f"{window['id']} {window['name']}")
    else:
        if len(r) == 1:
            print(f"{r[0]['id']} {r[0]['name']}")
            exit()

        window_opts = {"prev": -1, "next": 1}
        focused_window = next(
            (i for i, window in enumerate(r) if window.get("focused")), 0
        )
        next_index = (focused_window + 1) % len(r)
        i = r[next_index]
        print(f"{i['id']} {i['name']}")
