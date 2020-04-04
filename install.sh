#!/bin/bash

# install docker and docker compose
# we choose lasted community edition for free license and docker-compose 1.25.0
export DOCKER_COMPOSE_VERSION=1.25.0

source /etc/os-release

if [[ ${NAME} == *"Ubuntu"*  ||  ${NAME} == *"Debian"* ]]; then
  DISTRO=''
  if [[ ${NAME} == *"Ubuntu"* ]]; then
    DISTRO="ubuntu"
  elif [[ ${NAME} == *"Debian"* ]]; then
    DISTRO="debian"
  else
    echo "Cài bằng tay đi!!!!!!!!"
    exit 1
  fi

  apt-get update
  apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common
  curl -fsSL https://download.docker.com/linux/${DISTRO}/gpg | apt-key add -
  apt-key fingerprint 0EBFCD88
  add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/${DISTRO} $(lsb_release -cs) stable"
  apt-get update
  apt-get install -y docker-ce

elif [[ ${NAME} == *"CentOS"* ||  ${NAME} == *"Fedora"*  ]]; then
  yum check-update
  if [[ ${NAME} == *"CentOS"* ]]; then
    DISTRO="centos"
  elif [[ ${NAME} == *"Fedora"* ]]; then
    DISTRO="fedora"
  else
    echo "Cài bằng tay đi!!!!!!!!"
    exit 1
  fi
  yum install -y \
      yum-utils \
      device-mapper-persistent-data \
      lvm2 \
      curl

  yum-config-manager --add-repo https://download.docker.com/linux/${DISTRO}/docker-ce.repo
  yum check-update
  yum install -y docker-ce --nobest
else
  echo "Invalid argument"
  exit 1
fi

# Linux post-install
#groupadd docker
#usermod -aG docker $USER
systemctl enable docker
# install docker compose
curl -L \
  "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

mv /usr/local/bin/docker-compose /usr/bin/docker-compose

chmod +x /usr/bin/docker-compose

# build database and backup
source .env

docker-compose build

docker-compose up -d

echo "Create database";

docker-compose exec postgresql bash -c 'bash init_script.sh'