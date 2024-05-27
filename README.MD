# Simple and quick linux kernel build container
This image has all the dependencies required to build a linux kernel

# Usage

## Building a kernel
The line bellow will build the kernel in the folder `sample_folder` in this repository, using the `.config` file in the same folder, it will download the kernel version 6.8.11 and build it, you can change that by changing the `.kernel_url` file contents.
```bash
podman run --rm -v ./sample_folder:/build docker.io/xadaemon/kernel-builder:latest
```

## running menu config
Just run the command bellow and it will open the menu config
```bash
podman run --rm -it -v ./sample_folder:/build docker.io/xadaemon/kernel-builder:latest /bin/bash /scripts/setup_build.sh menuconfig
```
