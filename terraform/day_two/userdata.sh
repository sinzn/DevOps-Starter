#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install docker.io -y

sudo systemctl start docker 

sudo systemctl enable docker 

git clone https://github.com/sinzn/Docker-testing.git

cd Docker-testing || exit

sudo docker build -t dt .

sudo docker run -d -p 80:80 dt

echo " Your site is live at : $(curl -s ipinfo.me/ip)"
