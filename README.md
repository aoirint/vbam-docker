# vbam-docker
Run VisualBoyAdvance on Docker.

- https://github.com/visualboyadvance-m/visualboyadvance-m

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
sudo docker run -it --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix vbam /work/build/visualboyadvance-m
```

### Recover controlled access to your X screen
```sh
xhost -
```
