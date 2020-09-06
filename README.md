# vbam-docker
Run VisualBoyAdvance on Docker.

- https://github.com/visualboyadvance-m/visualboyadvance-m (GPLv2)

## Build

```sh
sudo docker build . -t vbam
```


## Run

### Allow local root user to access your display
```sh
xhost + local:root
```

### Run
```sh
sudo docker run -it --rm --name vbam \
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
```

### Recover controlled access to your X screen
```sh
xhost -
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

Open `Dockerfile`, and edit first few lines to use `nvidia/opengl` image instead `ubuntu` as base.
Then rebuild this image.
