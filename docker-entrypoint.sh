#!/bin/bash

set -eu

# docker run parameters for pulseaudio
# --group-add "$(getent group audio | cut -d: -f3)"
# -e "PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native"
# -v "${XDG_RUNTIME_DIR}/pulse/native/:${XDG_RUNTIME_DIR}/pulse/native"
# -v "${HOME}/.config/pulse/cookie:/tmp/pulseaudio_cookie"
PULSEAUDIO_COOKIE_TMP_MOUNT_PATH=/tmp/pulseaudio_cookie
VBAM_CONFIG_TMP_MOUNT_PATH=/tmp/vbam_conf

USER_NAME=user

useradd -u "${HOST_UID}" -o -m "${USER_NAME}"
groupmod -g "${HOST_GID}" "${USER_NAME}"

chown -R "${USER_NAME}:${USER_NAME}" /vbam

gosu "${USER_NAME}" mkdir -p "/home/${USER_NAME}/.config/pulse"
cp "${PULSEAUDIO_COOKIE_TMP_MOUNT_PATH}" "/home/${USER_NAME}/.config/pulse/cookie"
cp -r "${VBAM_CONFIG_TMP_MOUNT_PATH}" "/home/${USER_NAME}/.config/visualboyadvance-m"

gosu "${USER_NAME}" visualboyadvance-m "$@"
