variable "docker_version" {
  type = string
  default = "20.10.4"
}

variable "containerd_version" {
  type = string
  default = "1.4.3"
}

variable "box_version_major_minor" {
  type = string
  default = "2010.4"
}

variable "build_number" {
  type = number
}

variable "skip_shrink" {
  type = string
  default = ""
}

source "vagrant" "docker" {
  provider = "virtualbox"
  source_path = "jumperfly/centos-7"
  box_version = "7.9.17"
  communicator = "ssh"
  ssh_username = "root"
  ssh_password = "vagrant"
}

build {
  sources = ["sources.vagrant.docker"]
  provisioner "file" {
    source = "cloud-init-seed"
    destination = "/var/lib/cloud/seed"
  }
  provisioner "shell" {
    script = "provision.sh"
    environment_vars = [
      "CONTAINERD_VERSION=${var.containerd_version}",
      "DOCKER_VERSION=${var.docker_version}"
    ]
  }
  provisioner "shell" {
    script = "cleanup.sh"
    environment_vars = ["PACKER_SKIP_SHRINK_DISK=${var.skip_shrink}"]
  }
  post-processor "vagrant-cloud" {
    box_tag = "jumperfly/docker"
    version = "${var.box_version_major_minor}.${var.build_number}"
  }
}
