#/bin/sh

################################################################################
# Change History                                                               #
# 31/05/2021  Roman Ermolaev Original code. This is a template for creating     #
################################################################################

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

sudo yum install -y epel-release
yum update
yum install -y ansible
ansible --version
#echo "[servers]" > /etc/ansible/hosts
#echo "server1 ansible_host=127.0.0.1 ansible_port=10022"  >> /etc/ansible/hosts
#echo "[all:vars]" >> /etc/ansible/hosts
#echo "ansible_python_interpreter=/usr/bin/python3" >> /etc/ansible/hosts

#ansible-inventory --list -y
#ansible all -m ping -u dinky
#ansible all -a "df -h" -u dinky
