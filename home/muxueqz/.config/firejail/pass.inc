dbus-user filter

ignore dbus-user none

ignore nodbus
ignore protocol

noblacklist ${HOME}/.gnupg
whitelist ${HOME}/.gnupg
whitelist ${HOME}/.password-store/
include allow-python3.inc
noblacklist /usr/lib/passff/passff.py

# whitelist /usr/share/pyshared/
# noblacklist /usr/share/pyshared/

ignore noexec ${HOME}
ignore apparmor

writable-run-user
noblacklist ${RUNUSER}/gnupg
whitelist ${RUNUSER}/gnupg

read-only ${RUNUSER}/bus
