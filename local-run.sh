#!/bin/bash
vagrant destroy
if [[ -d "$HOME/.vagrant.d/boxes/.-VAGRANTSLASH-output-docker-VAGRANTSLASH-package.box" ]]; then
  vagrant box remove ./output-docker/package.box
fi
vagrant up
