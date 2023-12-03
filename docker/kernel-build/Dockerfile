FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

# Metadata params
ARG USER
ARG GROUP

# User config
ARG USERNAME=kb
ARG GROUPNAME=kb
ARG HOMEDIR=/home/kb
ARG USERSHELL=/bin/bash

RUN apt-get update -y \
    && apt-get upgrade -y \
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
RUN addgroup --gid $GROUP $GROUPNAME && \
    adduser --home $HOMEDIR --shell $USERSHELL --uid $USER --disabled-password --disabled-login --gid $GROUP $USERNAME

USER kb:kb
SHELL ["/bin/bash", "-c"]
