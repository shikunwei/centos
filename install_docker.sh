#!/bin/sh
set -e

# This script is meant for quick & easy reinstall docker:
#   $ sh install_docker.sh

# step 0: uninstall old version of docker
sudo yum remove -y docker docker-ce docker-ce-cli docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

# Step 1: Install some necessary system tools
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
#sudo yum install -y  http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.74-1.el7.noarch.rpm

# Step 2: Add the software source information
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# Step 3: Update and install Docker-CE
sudo yum makecache fast
sudo yum install -y docker-ce-19.03.4 docker-ce-cli-19.03.4

# Step 4: Accerlerate Docker by using Daocloud mirror
# curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io

# Step 5: Activate the Docker service and enable auto start when power on
sudo service docker start && systemctl enable docker
# config daemon.json
echo '{
  "insecure-registries": [
    "center.server:8082",
    "center.server:8083",
    "center.server:8084"
  ]
}' > /etc/docker/daemon.json
sudo service docker restart

# Step 6: install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

# Step 7: install docker-machine
# base=https://github.com/docker/machine/releases/download/v0.16.0
#   $ curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine
#   $ sudo install /tmp/docker-machine /usr/local/bin/docker-machine
#   $ sudo ln -sf /usr/local/bin/docker-machine /usr/bin/docker-machine

# Installation verification
docker version
#docker-compose -v
#   $ docker-machine -v

#
# physical_ip=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/'`
#   $ sudo docker swarm init --advertise-addr ${physical_ip}

# Uninstall docker commands:
#   $ docker container stop $(docker container ls -aq) && docker container rm $(docker container ls -aq)
#   $ docker system prune
#   $ docker system prune --volumes
#   $ docker image prune -a
#
#   $ sudo yum remove -y docker-ce
#   $ sudo rm -rf /var/lib/docker
#
#   $ sudo rm /usr/local/bin/docker-compose
#
#   $ docker-machine rm -f $(docker-machine ls -q)
#   $ sudo rm $(which docker-machine)
