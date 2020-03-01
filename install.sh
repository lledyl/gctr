#!/bin/bash/

sudo apt-get update
sudo apt-get -y install unzip
sudo apt-get -y install nano
sudo apt-get -y install cron
curl https://rclone.org/install.sh | sudo bash
sudo apt-get -y install python-pip
sudo apt-get -y install python3-venv
python3 -m venv ~/flexget/
cd ~/flexget/
bin/pip install flexget
pip install transmissionrpc
cd $home
sudo apt-get -y install transmission-cli  transmission-daemon
sudo usermod -a -G debian-transmission $USER
sudo service transmission-daemon restart
cd /usr/share/transmission/
sudo wget https://github.com/Secretmapper/combustion/archive/release.zip -O release.zip
sudo unzip -o release.zip
sudo mv web web_orig
sudo mv combustion-release/ web
sudo rm release.zip
cd $home
wget https://raw.githubusercontent.com/lledyl/gctr/master/gsupload.sh -O gsupload.sh
chmod +x gsupload.sh
wget https://raw.githubusercontent.com/lledyl/gctr/master/config.yml -O config.yml
wget https://github.com/lledyl/gctr/blob/master/gfilter.txt -O gfilter.txt
wget https://gist.githubusercontent.com/pawelszydlo/e2e1fc424f2c9d306f3a/raw/c26087d4b4f696bd373b02c0e294fb92dec1039a/transmission_remove_finished.sh -O transmission_remove_finished.sh
mv transmission_remove_finished.sh .rtorrents.sh
mkdir c
mkdir s
sudo chown -R $USER:$USER c
sudo chown -R $USER:$USER s
chmod -R 777 c
chmod -R 777 s

