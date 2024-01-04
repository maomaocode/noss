#!/bin/bash

# 创建并切换到 /data 目录
mkdir /data && cd /data

# install open ssl
wget https://www.openssl.org/source/openssl-1.1.1w.tar.gz --no-check-certificate
tar -xf openssl-1.1.1w.tar.gz
cd openssl-1.1.1w
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl
make && make install
echo "/usr/local/openssl/lib" > /etc/ld.so.conf.d/openssl.conf
ldconfig
rm -rf /usr/bin/openssl
ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl

# install python3
wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
sudo yum -y install gcc zlib* libffi-devel
tar -xzvf Python-3.10.4.tgz
cd Python-3.10.4/

mkdir /usr/local/python3
./configure --prefix=/usr/local/python3 --with-openssl=/usr/local/openssl
make && make install 

rm -rf /usr/bin/python3
rm -rf /usr/bin/pip3

ln -s /usr/local/python3/bin/python3  /usr/bin/python3
ln -s /usr/local/python3/bin/pip3  /usr/bin/pip3

python3 --version
pip3 --version

# 安装 Git

yum install -y git

cd /data
git clone https://github.com/maomaocode/noss.git
cd noss/

pip3 install requests
pip3 install websocket
pip3 install websocket-client
pip3 install pynostr

yum install centos-release-scl
yum install devtoolset-8
source /opt/rh/devtoolset-8/enable



