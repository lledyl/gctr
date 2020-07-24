#!/bin/bash
sudo apt-get update
sudo apt-get install unzip
sudo apt-get install screen git && curl https://rclone.org/install.sh | sudo bash
sudo apt-get install -y python3
sudo apt-get install -y python3-pip
sudo git clone https://github.com/xyou365/AutoRclone && cd AutoRclone && sudo pip3 install -r requirements.txt
