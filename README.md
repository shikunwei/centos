# Initialize centos 7

This GitHub repository contains scripts to initialize centos 7 and setup docker

### one line command to initialize centos and install docker
```
curl https://raw.githubusercontent.com/shikunwei/centos/master/update_yum_repo.sh -o update_yum_repo.sh && \
sh update_yum_repo.sh && \
curl https://raw.githubusercontent.com/shikunwei/centos/master/install_docker.sh -o install_docker.sh && \
sh install_docker.sh
```
It will use local yum repo and docker repo in nexus



### Use by clone this repo
Clone:
```
sudo yum -y install git && git clone https://github.com/shikunwei/centos.git && cd centos
```

Initialize centos:
```
sh initialize_centos.sh
```

Install docker:
```
sh install_docker.sh
```