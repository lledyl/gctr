#!/bin/bash/

sudo apt-get update
sudo apt-get -y install unzip
sudo apt-get -y install nano
sudo apt-get -y install bmon
sudo apt-get -y install screen
sudo apt-get -y install cron
curl https://rclone.org/install.sh | sudo bash
sudo apt-get -y install python3-venv
python3 -m venv ~/flexget/
cd ~/flexget/
bin/pip install flexget
source ~/flexget/bin/activate
easy_install transmissionrpc
cd $home
sudo apt-get -y install transmission-cli  transmission-daemon
sudo service transmission-daemon stop
wget https://raw.githubusercontent.com/lledyl/gctr/master/settings.json
sudo mv settings.json /etc/transmission-daemon/settings.json
sudo usermod -a -G debian-transmission $USER
cd /usr/share/transmission/
sudo wget https://github.com/Secretmapper/combustion/archive/release.zip -O release.zip
sudo unzip -o release.zip
sudo mv web web_orig
sudo mv combustion-release/ web
sudo rm release.zip
sudo service transmission-daemon start
cd $home
wget https://raw.githubusercontent.com/lledyl/gctr/master/gsupload.sh -O gsupload.sh
chmod +x gsupload.sh
wget https://raw.githubusercontent.com/lledyl/gctr/master/config.yml -O config.yml
wget https://raw.githubusercontent.com/lledyl/gctr/master/gfilter.txt -O gfilter.txt
wget https://gist.githubusercontent.com/pawelszydlo/e2e1fc424f2c9d306f3a/raw/c26087d4b4f696bd373b02c0e294fb92dec1039a/transmission_remove_finished.sh -O transmission_remove_finished.sh
mv transmission_remove_finished.sh .rtorrents.sh
sudo mkdir /c
sudo mkdir /s
sudo chmod -R 777 /c
sudo chmod -R 777 /s
sudo chown -R $USER:$USER /c
sudo chown -R $USER:$USER /s

echo "sudo nano /etc/transmission-daemon/settings.json" >> help.txt
echo "~/flexget/bin/flexget --test execute" >> help.txt
echo "sudo service transmission-daemon start" >> help.txt
echo "mv gs/temp/*/*.* gs/temp/" >> help.txt
echo "find /dir -type d -empty -print" >> help.txt
echo "@reboot rm -r /s/*
* * * * * sudo chown -R $USER:$USER /c/*
* * * * * sh /home/$USER/gsupload.sh" >> help.txt
