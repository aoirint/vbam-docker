#!/bin/bash

docker run --rm \
  -e DISPLAY \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  --gpus all \
  --group-add "$(getent group audio | cut -d: -f3)" \
  -e "PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
  -v "${XDG_RUNTIME_DIR}/pulse/native/:${XDG_RUNTIME_DIR}/pulse/native" \
  -v "${HOME}/.config/pulse/cookie:/tmp/pulseaudio_cookie" \
  -e "HOST_UID=$(id -u $USER)" \
  -e "HOST_GID=$(id -g $USER)" \
  -v "${VBAM_DATA_DIR:-vbam}:/vbam" \
  -v "${VBAM_CONF_DIR:-vbam-conf}:/tmp/vbam_conf" \
  aoirint/vbam
