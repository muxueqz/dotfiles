#!/usr/bin/env python
import sys
import json

focused_workspace = ''

def extract_nodes_iterative(workspace):
    """Extracts all windows from a sway workspace json object"""
    all_nodes = []

    floating_nodes = workspace.get('floating_nodes')

    for floating_node in floating_nodes:
        floating_node['workspace'] = workspace.get('num', -9999)
        all_nodes.append(floating_node)

    nodes = workspace.get('nodes')

    for node in nodes:

        # Leaf node
        if len(node.get('nodes')) == 0:
            node['workspace'] = workspace['num']
            if node.get('focused'):
                global focused_workspace
                focused_workspace = workspace.get('id')
            all_nodes.append(node)
        # Nested node, handled iterative
        else:
            for inner_node in node.get('nodes'):
                inner_node['workspace'] = workspace['num']
                nodes.append(inner_node)

    return all_nodes

def get_windows(only_workspace=False):
    """Returns a list of all json window objects"""
    command = ['swaymsg', '-t', 'get_tree']
    data = json.load(sys.stdin)

    # Select outputs that are active
    workspace_windows = {}
    for output in data['nodes']:

        # The scratchpad (under __i3) is not supported
        # if output.get('name') != '__i3' and output.get('type') == 'output':
        if output.get('type') == 'output':
            workspaces = output.get('nodes')
            for workspace in workspaces:
                if workspace.get('type') == 'workspace':
                    workspace_id = workspace.get('id')
                    windows = workspace_windows.setdefault(workspace_id, [])
                    windows += extract_nodes_iterative(workspace)
    windows = []
    for k, v in workspace_windows.items():
        if only_workspace and k != focused_workspace:
            continue
        windows.extend(v)
    return windows

if __name__ == "__main__":
    only_workspace = False
    try:
        if sys.argv[1] == 'current_workspace':
            only_workspace = True
    except Exception as e:
        pass
    r = get_windows(only_workspace)
    for i in r:
        print('%s %s' % (i['id'], i['name']))
