#!/bin/bash/

sudo apt-get update
sudo apt-get -y install python3-venv
python3 -m venv ~/flexget/
cd ~/flexget/
bin/pip install flexget
source ~/flexget/bin/activate
easy_install transmissionrpc
cd $home
