#!/bin/bash

sudo apt-get update
sudo apt-get install unzip
sudo apt-get install screen git && curl https://rclone.org/install.sh | sudo bash
sudo apt-get -y install python3
sudo apt-get -y install python3-pip
sudo pip3 install google-api-python-client==1.12.1
sudo git clone https://github.com/xyou365/AutoRclone && cd AutoRclone && sudo pip3 install -r requirements.txt
