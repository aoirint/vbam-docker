#!/bin/bash
docker run -it --rm --name vbam \
  -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --gpus all \
  --group-add $(getent group audio | cut -d: -f3) \
  -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
  -v ${XDG_RUNTIME_DIR}/pulse/native/:${XDG_RUNTIME_DIR}/pulse/native \
  -v ${HOME}/.config/pulse/cookie:/root/.config/pulse/cookie \
  -v ${PWD}/vbam:/vbam \
  -v ${PWD}/vbam-conf:/root/.config/visualboyadvance-m \
  vbam \
  visualboyadvance-m
