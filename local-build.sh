#!/bin/bash
rm -rf output*
if [[ -d "$HOME/.vagrant.d/boxes/.-VAGRANTSLASH-output-docker-VAGRANTSLASH-package.box" ]]; then
  vagrant box remove ./output-docker/package.box
fi
packer build -except 'vagrant-cloud' -var build_number=0 -var skip_shrink=1 .
