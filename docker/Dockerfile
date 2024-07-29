FROM ubuntu:20.04

ARG USER
ARG UID
ARG PWD
WORKDIR $PWD

RUN rm /etc/apt/apt.conf.d/docker-*
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install sudo bash-completion tmux \
     gawk wget git git-lfs diffstat unzip texinfo gcc \
     build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
     pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool locales curl libncurses-dev \
     python-is-python3 wpasupplicant python3-requests libconfig9 xxd
RUN sed -i 's/# en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
RUN locale-gen
RUN useradd -m -G sudo -s /bin/bash -U -u ${UID} ${USER}
RUN cp /etc/skel/.bash_logout /etc/skel/.bashrc /etc/skel/.profile /home/${USER}/
RUN chown ${USER}:${USER} /home/${USER} -R
RUN sed -E -i 's/^(%sudo.*)/#\1\n%sudo ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

USER ${USER}
ENV USER=${USER}
ENV LANG=en_US.UTF-8
