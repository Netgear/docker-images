#!/bin/bash
set -e
echo "Creating docker image for M7 webapp builds"
docker build -t "m7_webapp_builder_u2204:latest" \
            --build-arg HOST_UID="$(id -u)" \
            --build-arg HOST_GID="$(id -g)" \
            -f Dockerfile .
