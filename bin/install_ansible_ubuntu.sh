#!/bin/sh

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "===================== started  ansible installation ==============================="
apt-get update >> /dev/null
sudo apt-get install ansible -y
echo "===================== finished ansible installation ==============================="
ansible --version
