#!/bin/bash/

sudo apt-get update
sudo apt-get -y install unzip
sudo apt-get -y install nano
sudo apt-get -y install cron
curl https://rclone.org/install.sh | sudo bash
sudo apt-get -y install python3-venv
python3 -m venv ~/flexget/
cd ~/flexget/
bin/pip install flexget
pip install transmissionrpc
sudo apt-get -y install transmission-cli  transmission-daemon
sudo service transmission-daemon stop
sudo usermod -a -G debian-transmission $USER
sudo service transmission-daemon start
mkdir c
mkdir s
chmod -R 777 c
chmod -R 777 s
cd /usr/share/transmission/
sudo wget https://github.com/Secretmapper/combustion/archive/release.zip
sudo unzip release.zip
sudo mv web web_orig
sudo mv combustion-release/ web
sudo rm release.zip
cd $home
