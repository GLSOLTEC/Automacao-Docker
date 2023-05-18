#!/bin/bash

read -p "Login github: " login
read -p "Token: " token



echo "###INSTALAÇÃO DOCKER ###"
apt purge docker-* -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt install docker-compose -y
cd ../
git clone https://$login:$token@github.com/mmarinhols/rmserver.git
git clone https://$login:$token@github.com/mmarinhols/rmwebhook.git
git clone https://$login:$token@github.com/mmarinhols/rmwhatsapp.git
git clone https://$login:$token@github.com/mmarinhols/rmzapservice.git

echo "###POTAINER###"
docker-compose -f ../portainer/portainer.yaml up -d

echo "###REPORT MED DATABASE###"
docker-compose -f ../rmdatabase/rmdatabase.yaml up -d

#echo "###REPORT MED FTP###"
#docker-compose -f ../rmftp/rmftp.yaml up -d

#echo "###REPORT MED ORTHANC###"
#docker-compose -f ../rmorthanc/rmorthanc.yaml up -d

echo "###REPORT MED SERVER###"
docker-compose -f ../rmserver/rmserver.yaml up -d

echo "###REPORT MED WEBHOOK###"
docker-compose -f ../rmwebhook/rmwebhook.yaml up -d

echo "###REPORT MED WHATSAPP###"
docker-compose -f ../rmwhatsapp/rmwhatsapp.yaml up -d

echo "###REPORT MED WHATSAPP API###"
docker-compose -f ../rmzapservice/rmzapservice.yaml up -d

exit 0
