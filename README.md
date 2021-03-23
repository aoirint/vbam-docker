# vbam-docker
Run VisualBoyAdvance-M in Docker.

- https://github.com/visualboyadvance-m/visualboyadvance-m (GPLv2)

```shell
make run
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
