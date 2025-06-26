#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install docker.io figlet lolcat -y

sudo echo "figlet server | lolcat" >> .bashrc

sudo systemctl start docker

sudo usermod -aG docker $USER | newgrp docker 

git clone https://github.com/sinzn/terra.git

cd terra || exit

sudo docker build -t terra-srv .

sudo docker run -d -p 80:80 terra-srv

echo " terra-srv depolyment complete, check here : $(curl -s ipinfo.io/ip) "
