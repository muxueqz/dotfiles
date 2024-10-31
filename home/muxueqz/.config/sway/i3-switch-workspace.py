#!/usr/bin/env python

from json import loads
from os import popen
from sys import argv
import i3_tools

def ipc_query(req=i3_tools.I3_IPC_MESSAGE_TYPE_COMMAND, msg=""):
    print((req, msg))
    ans = i3_tools.i3_msg(req, msg)
    return loads(ans)

if __name__ == "__main__":
    # Usage & checking args
    if len(argv) != 2:
        print("Usage: switch-workspace.py name-of-workspace")
        exit(-1)

    newworkspace = argv[1]

    # Retrieving active display
    active_display = None
    old_display = None
    # for w in ipc_query(req="get_workspaces"):
    ws = i3_tools.i3_msg(i3_tools.I3_IPC_MESSAGE_TYPE_WORKSPACE)
    for w in loads(ws):
        if w['focused']:
            active_display = w['output']
            print(w)
        if str(w['num']) == newworkspace:
            print(w)
            old_display = w['output']

    if active_display == old_display:
        # msg = "'workspace number %s'" % newworkspace
        msg = "workspace number %s" % newworkspace
        print(ipc_query(msg=msg))
        exit(0)
    # Moving workspace to active display
    msg = "'workspace number %s; move workspace to output %s; workspace number %s'" % (newworkspace,
        active_display, newworkspace)
    # print ipc_query(msg="'workspace " + newworkspace + "; move workspace to output " + active_display + "; workspace " + newworkspace + "'")
    print(ipc_query(msg=msg))
