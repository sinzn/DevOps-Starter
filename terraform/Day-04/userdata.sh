#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install docker.io -y

sudo systemctl start docker

sudo usermod -aG docker $USER | newgrp docker

cd web

sudo docker build -t tsrv .

sudo docker run -d -p 80:80 tsrv

echo "tsrv deployment done check here $(curl -s ipinfo.io/ip)"
