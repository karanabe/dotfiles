FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Metadata params
ARG HOST_UID=1000
ARG HOST_GID=1000

# User config
ARG USERNAME=kb
ARG GROUPNAME=kb
ARG HOMEDIR=/home/kb
ARG USERSHELL=/bin/bash

RUN apt-get update -y \
    && yes '' | apt-get -y -o DPkg::options::="--force-confdef" \
      -o DPkg::options::="--force-confold" install -y \
      git \
      vim \
      bc \
      build-essential \
      flex \
      bison \
      libssl-dev \
      libelf-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Setup Timezone
ENV TZ='Asia/Tokyo'

# Setup kernel build user
RUN addgroup --gid "$HOST_GID" "$GROUPNAME" && \
    adduser --home "$HOMEDIR" --shell "$USERSHELL" --uid "$HOST_UID" --disabled-password --disabled-login --gid "$HOST_GID" "$USERNAME"

USER kb:kb
SHELL ["/bin/bash", "-c"]
