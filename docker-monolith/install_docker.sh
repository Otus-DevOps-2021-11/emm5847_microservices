#!/usr/bin/env bash

#Wait until apt finishes
while true
do
  if [[ $(ps aux | grep -c 'apt.systemd.daily') > 1 ]]
  then
    sleep 1
  else
    break
  fi
done

#Install additional packages
sudo apt-get update
sudo apt-get -y install ca-certificates curl gnupg lsb-release

#Import gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#Add docker repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Install docker
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

#Check version
docker version
echo

if [ $? -eq 0 ]
then
  echo "Installation is successfull"
else
  echo "Installation Error"
  exit 1
fi
