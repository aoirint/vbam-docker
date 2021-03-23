#!/bin/bash

set -eu

USER_NAME=user

useradd -u "${HOST_UID}" -o -m "${USER_NAME}"
groupmod -g "${HOST_GID}" "${USER_NAME}"

gosu "${USER_NAME}" mkdir -p "/home/${USER_NAME}/.config/pulse"
ln -s /pulseaudio/cookie "/home/${USER_NAME}/.config/pulse/cookie"

chown -R "${USER_NAME}:${USER_NAME}" /vbam
ln -s "/vbam_conf" "/home/${USER_NAME}/.config/visualboyadvance-m"

gosu "${USER_NAME}" "$@"
