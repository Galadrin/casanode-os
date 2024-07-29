#!/usr/bin/env bash

set -e

mkdir -p ${REPO_DIR} && cd ${REPO_DIR}

git config --global user.name "docker runner"
git config --global user.email "docker.runner@fake.fr"

if [ ! -e yocto-cooker ]; then
  git clone https://github.com/cpb-/yocto-cooker
  cd yocto-cooker
  sudo pip3 install .
  cd -
fi

rm -rf ./build/conf

exec $SHELL
