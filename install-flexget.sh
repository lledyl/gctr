#!/bin/bash/

sudo apt-get update
sudo apt-get -y install unzip
sudo apt-get -y install nano
sudo apt-get -y install bmon
sudo apt-get -y install screen
sudo apt-get -y install cron
sudo apt-get -y install vim
curl https://rclone.org/install.sh | sudo bash
sudo apt-get -y install python3-venv
python3 -m venv ~/flexget/
cd ~/flexget/
bin/pip install flexget
source ~/flexget/bin/activate
easy_install transmissionrpc
cd $home

echo "~/flexget/bin/flexget --test execute" >> help.txt
echo "mv gs/temp/*/*.* gs/temp/" >> help.txt
