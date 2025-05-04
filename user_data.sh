#!/bin/bash

sudo apt update && apt upgrade -y

sudo apt install -y ca-certificates wget amazon-efs-utils

sudo apt install docker -y

sudo systemctl enable docker 
sudo systemctl start docker

sudo usermod -aG docker ubuntu

curl -L https://github.com/docker/compose/releases/download/v2.35.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

mkdir -p /efs/data

mount -t efs -o fs-0dc126170e759e811.efs.us-east-1.amazonaws.com:/ /efs/data

wget -O /home/ubuntu/docker-compose.yml https://raw.githubusercontent.com/rafdavis/Projeto_AWS_Docker/refs/heads/main/docker-compose.yml
sudo chown ubuntu:ubuntu /home/ubuntu/docker-compose.yml  

cd /home/ubuntu/docker-compose.yml
docker-compose up -d