#!/bin/bash
set -e

# This script is meant for quick & easy setup centos:
# Tested on minimal version of centos 7
#   $ sh initialize_centos.sh

# 修改源
#	1. 把原来的源文件备份
mkdir -p /etc/yum.repos.d/backup
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup
#   使用本地nexus中的软件源
echo '[base]
name=CentOS-$releasever - Base
baseurl=http://center.server:8081/repository/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates 
[updates]
name=CentOS-$releasever - Updates
baseurl=http://center.server:8081/repository/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
baseurl=http://center.server:8081/repository/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
baseurl=http://center.server:8081/repository/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[nexus-epel]
name = EPEL YUM repo
baseurl = http://center.server:8081/repository/centos/$releasever/$basearch
failovermethod = priority
gpgcheck = 0

[nexus-epel-debuginfo]
name = Extra Packages for Enterprise Linux $releasever - $basearch - Debug
baseurl = http://center.server:8081/repository/centos/$releasever/$basearch/debug
failovermethod = priority
enabled = 0
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
gpgcheck = 0

[nexus-epel-source]
name = Extra Packages for Enterprise Linux $releasever - $basearch - Source
baseurl = http://center.server:8081/repository/centos/$releasever/SRPMS
failovermethod = priority
enabled = 0
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
gpgcheck = 0

#######################################################
# PGDG Red Hat Enterprise Linux / CentOS repositories #
#######################################################

# PGDG Red Hat Enterprise Linux / CentOS stable common repository for all PostgreSQL versions
[pgdg-common]
name=PostgreSQL common RPMs for RHEL/CentOS $releasever - $basearch
baseurl=http://center.server:8081/repository/centos/common/redhat/rhel-$releasever-$basearch
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG

# PGDG Red Hat Enterprise Linux / CentOS stable repositories:
[pgdg10]
name=PostgreSQL 10 for RHEL/CentOS $releasever - $basearch
baseurl=http://center.server:8081/repository/centos/10/redhat/rhel-$releasever-$basearch
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG
' > /etc/yum.repos.d/nexus.repo
#	3. 清除缓冲
sudo yum clean all
#	4. 生成新缓冲
sudo yum makecache
#	5. 更新源
sudo yum -y update
#   6. 安装必备软件
sudo yum -y install git net-tools wget yum-utils unzip
