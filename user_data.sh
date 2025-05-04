#!/bin/bash

sudo yum update -y

sudo yum install ca-certificates wget amazon-efs-utils docker -y 
sudo systemctl enable docker && sudo systemctl start docker
sudo usermod -aG docker ec2-user && newgrp docker

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo mkdir -p /efs/data
sudo mount -t efs -o tls <DNS NAME>:/ /efs/data

sudo wget -O /home/ec2-user/docker-compose.yml https://raw.githubusercontent.com/rafdavis/Projeto_AWS_Docker/refs/heads/main/docker-compose.yml
sudo chown ec2-user:ec2-user docker-compose.yml

docker-compose up -d