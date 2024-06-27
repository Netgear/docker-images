#!/bin/bash
set -eu

USERNAME="${USERNAME:-webapp_builder}"
WEBAPP_DIR="${WORKSPACE}/webapp"

DEFAULT_ID=$(stat -c "%u" "${WEBAPP_DIR}")
HOST_UID="${HOST_UID:-$DEFAULT_ID}"
HOST_GID="${HOST_GID:-$DEFAULT_ID}"

# Update user with HOST User ID and Group ID
usermod --uid "$HOST_UID" "${USERNAME}"
groupmod --gid "$HOST_GID" "${USERNAME}"

cd "$WEBAPP_DIR"

# If a command is provided, execute; otherwise, start a bash shell
if [ "$#" -gt 0 ]; then
    exec gosu "${USERNAME}" bash -c "$@"
else
    exec gosu "${USERNAME}" bash
fi
