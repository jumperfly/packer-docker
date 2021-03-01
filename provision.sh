#!/bin/bash

# Configure network
systemctl disable firewalld
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux


# Install packages
curl -o /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install containerd.io-$CONTAINERD_VERSION docker-ce-cli-$DOCKER_VERSION docker-ce-$DOCKER_VERSION
systemctl enable docker
