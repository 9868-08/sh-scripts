#!/bin/sh

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "===================== started  docker installation ==============================="
apt-get update >> /dev/null
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-get update >> /dev/null
apt-cache policy docker-ce
apt-get install docker-ce -y
systemctl status docker
usermod -aG docker ${USER}
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/loc              al/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo "===================== finished docker installation ==============================="
docker-compose --version
docker --version


