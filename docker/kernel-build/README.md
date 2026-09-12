# Linux kernel build image

The image uses Ubuntu 20.04 and installs the standard Linux kernel build tools.
It creates a `kb` user using the invoking user's UID and GID so files written to
mounted volumes remain owned by the host user.

## Build

From any directory in this repository:

```shell
docker/kernel-build/build.sh
```

This creates `kernelbuild:latest`.

## Run

When `.local/bin` is on `PATH`:

```shell
dkb
dkb root
dkb kb /path/to/script
```

The container mounts the `kernel` volume at `/home/kb/kernel` and removes the
container when the interactive session ends.

For WSL2 kernels, one typical build command is:

```shell
make LOCALVERSION=-original KCONFIG_CONFIG=Microsoft/config-wsl -j"$(nproc)"
```
