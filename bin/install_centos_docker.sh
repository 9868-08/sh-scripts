#/bin/sh

################################################################################
# Change History                                                               #
# 15/02/2024  Roman Ermolaev Original code. This is a template for creating     #
################################################################################

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Uninstall old versions"
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl start docker
systemctl enable docker
docker ps -a

curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
groupadd docker
usermod -aG docker $USER
