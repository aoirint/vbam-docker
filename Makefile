ROOT_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
COMMAND =

build:
	docker build . -t aoirint/vbam

run: build
	docker run --rm -it \
	  -e DISPLAY \
	  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
	  --gpus all \
	  --group-add "$(shell getent group audio | cut -d: -f3)" \
	  -e "PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
	  -v "${XDG_RUNTIME_DIR}/pulse/native/:${XDG_RUNTIME_DIR}/pulse/native" \
	  -v "${HOME}/.config/pulse/cookie:/pulseaudio/cookie" \
	  -e "HOST_UID=$(shell id -u)" \
	  -e "HOST_GID=$(shell id -g)" \
	  -v "${ROOT_DIR}/vbam_data:/vbam" \
	  -v "${HOME}/.config/visualboyadvance-m:/vbam_conf" \
	  aoirint/vbam ${COMMAND}
