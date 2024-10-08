#!/usr/bin/env python
import sys
import json
import socket
import struct
import os

focused_workspace = ""

# Constants for i3/sway IPC
I3_IPC_MAGIC = b"i3-ipc"
I3_IPC_MESSAGE_TYPE_GET_TREE = 4
I3_IPC_MESSAGE_TYPE_COMMAND = 0

# Get SWAYSOCK or I3 socket from environment
sway_socket = os.environ.get("SWAYSOCK")
i3_socket = os.environ.get("I3SOCK")

# Use SWAYSOCK if available, otherwise fallback to I3SOCK
ipc_socket_path = sway_socket or i3_socket

if not ipc_socket_path:
    raise RuntimeError("Could not find SWAYSOCK or I3SOCK in environment")


def i3_msg(message_type, payload=""):
    # Create socket and connect to the IPC
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
        sock.connect(ipc_socket_path)

        # Prepare message
        payload_bytes = payload.encode("utf-8")
        message_length = len(payload_bytes)

        # Pack the header (I3_IPC_MAGIC + length + message type)
        header = struct.pack("=6sII", I3_IPC_MAGIC, message_length, message_type)

        # Send the message (header + payload)
        sock.sendall(header + payload_bytes)

        # Read the response header (6sII) => magic string (6 bytes), message length (4 bytes), message type (4 bytes)
        response_header = sock.recv(14)
        magic, response_length, response_type = struct.unpack("=6sII", response_header)

        # Verify response magic string
        if magic != I3_IPC_MAGIC:
            raise RuntimeError("Invalid IPC magic in response")

        # Read the actual response payload based on the reported length
        response_payload = sock.recv(response_length)

        return response_payload.decode("utf-8")


def extract_nodes_iterative(workspace):
    """Extracts all windows from a sway workspace json object"""

    def process_node(node, workspace):
        node["workspace"] = workspace["id"]
        if node.get("focused"):
            global focused_workspace
            focused_workspace = workspace.get("id")

    all_nodes = []

    floating_nodes = workspace.get("floating_nodes")

    for floating_node in floating_nodes:
        process_node(floating_node, workspace)
        all_nodes.append(floating_node)

    nodes = workspace.get("nodes")

    for node in nodes:
        # Leaf node
        if len(node.get("nodes")) == 0:
            process_node(node, workspace)
            all_nodes.append(node)
        # Nested node, handled iterative
        else:
            for inner_node in node.get("nodes"):
                inner_node["workspace"] = workspace["num"]
                nodes.append(inner_node)

    return all_nodes


def get_windows(only_workspace=False):
    """Returns a list of all json window objects"""
    tree_json = i3_msg(I3_IPC_MESSAGE_TYPE_GET_TREE)
    data = json.loads(tree_json)

    # Select outputs that are active
    workspace_windows = {}
    for output in data["nodes"]:
        # The scratchpad (under __i3) is not supported
        # if output.get('name') != '__i3' and output.get('type') == 'output':
        if output.get("type") == "output":
            workspaces = output.get("nodes")
            for workspace in workspaces:
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
    only_workspace = False
    try:
        if sys.argv[1] == "current_workspace":
            only_workspace = True
    except Exception as e:
        pass
    r = get_windows(only_workspace)
    for n, i in enumerate(r):
        print(f"{n+1}. {i['id']} {i['name']}")
