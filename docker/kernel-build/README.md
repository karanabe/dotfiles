# Docker image for linux kernel build

OS: Ubuntu 20.04

packages: default build tools and git, vim, bc


## WSL2 kernel build

`make LOCALVERSION=-original KCONFIG_CONFIG=Microsoft/config-wsl -j6`


## Check processor count

`fgrep 'processor' /proc/cpuinfo | wc -l`


## Change remote branch

`git branch -r`

`git checkout -b linux-msft-wsl-5.10.y origin/linux-msft-wsl-5.10.y`


## Docker volume permission

`chown $(id -u):$(id -g) -R /home/kb/kernel`


## Usage

```bash
#!/bin/bash

DOCKER_USER="kb"
DOCKER_SCRIPT="--login"

if [ $# == 1 ]; then
  DOCKER_USER=$1
fi

if [  $# == 2 ]; then
  DOCKER_USER=$1
  DOCKER_SCRIPT=$2
fi

docker container run \
  --net=bridge \
  -v kernel:/home/kb/kernel \
  -v /tmp:/home/kb/tmp \
  -w /home/kb \
  -it --rm \
  -e TZ=Asia/Tokyo \
  -e TERM=xterm-256color \
  -e IS_DOCKER=true \
  --user $DOCKER_USER \
  --name kernel-build \
  --hostname KERNELBUILD \
  kb:latest \
  /bin/bash $DOCKER_SCRIPT
```


### License

<sup>
Licensed under <a href="LICENSE">The Unlicense</a>.
</sup>