  #!/bin/bash
set -e

# This script is meant for quick & easy setup centos:
# Tested on minimal version of centos 7
#   $ sh initialize_centos.sh

# 修改源
#	1. 把原来的源文件备份
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
#	2. 从阿里云下载源文件
# wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#   或者使用本地nexus中的软件源
cp ./files/nexus.repo /etc/yum.repos.d/nexus.repo
#	3. 清除缓冲
sudo yum clean all
#	4. 生成新缓冲
sudo yum makecache
#	5. 更新源
sudo yum -y update
#   6. 安装必备软件
sudo yum -y install git net-tools wget yum-utils unzip
