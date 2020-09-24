# vbam-docker
Run VisualBoyAdvance-M in Docker.

- https://github.com/visualboyadvance-m/visualboyadvance-m (GPLv2)

## Run
To use local data directory,
replace `"${VBAM_DATA_DIR:-vbam}:/vbam"` to `"ABSOLUTE_HOST_DIR_PATH:/vbam"`,
or set environment variable `VBAM_DATA_DIR` to the absolute directory path that you want.

### Docker Volume & Non-NVIDIA
```sh
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
  -v "${VBAM_DATA_DIR:-vbam-data}:/vbam" \
  -v "${VBAM_CONF_DIR:-vbam-conf}:/tmp/vbam_conf" \
  aoirint/vbam
```

### Local directory & NVIDIA
```sh
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
  -v "${VBAM_DATA_DIR:-${PWD}/vbam-data}:/vbam" \
  -v "${VBAM_CONF_DIR:-${PWD}/vbam-conf}:/tmp/vbam_conf" \
  aoirint/vbam:nvidia
```


## Error
### libGL error: No matching fbConfigs or visuals found
```
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
The program 'visualboyadvance-m' received an X Window System error.
This probably reflects a bug in the program.
The error was 'GLXBadContext'.
  (Details: serial 2859 error_code 170 request_code 154 minor_code 6)
  (Note to programmers: normally, X errors are reported asynchronously;
   that is, you will receive the error a while after causing it.
   To debug your program, run it with the --sync command line
   option to change this behavior. You can then get a meaningful
   backtrace from your debugger if you break on the gdk_x_error() function.)
```

Are you using nvidia-driver on the host machine?

Use `nvidia/opengl` image instead `ubuntu` as base.
