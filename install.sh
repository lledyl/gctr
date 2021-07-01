#!/bin/bash/
#Install on Ubuntu 20 LTS

sudo apt-get update
sudo apt-get -y install wget
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
pip install transmission-rpc -U

cd $home
sudo apt-get -y install transmission-cli  transmission-daemon
sudo service transmission-daemon stop
sleep 5
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
sleep 5

cd $home
wget https://raw.githubusercontent.com/lledyl/gctr/master/upload.sh -O upload.sh
chmod +x gsupload.sh
wget https://raw.githubusercontent.com/lledyl/gctr/master/config.yml -O config.yml
wget https://raw.githubusercontent.com/lledyl/gctr/master/filter.txt -O filter.txt
wget https://raw.githubusercontent.com/lledyl/gctr/master/helpcommands.txt -O help.txt

wget https://gist.githubusercontent.com/pawelszydlo/e2e1fc424f2c9d306f3a/raw/c26087d4b4f696bd373b02c0e294fb92dec1039a/transmission_remove_finished.sh -O transmission_remove_finished.sh
mv transmission_remove_finished.sh .clean_transmission.sh

crontab -l > mycron
echo "* * * * * sh /home/$USER/upload.sh" >> mycron
echo "#*/30 * * * * ~/flexget/bin/flexget execute" >> mycron
echo "* * * * * sudo chown -R $USER:$USER /complete/*" >> mycron
echo "*/15 * * * * sh .clean_transmission.sh" >> mycron
echo "#@reboot rm -r /incomplete/*" >> mycron
crontab mycron
rm mycron

sudo mkdir /complete
sudo mkdir /incomplete
sudo chmod -R 777 /complete
sudo chmod -R 777 /incomplete
sudo chown -R $USER:$USER /complete
sudo chown -R $USER:$USER /incomplete


sudo ln -s /incomplete/ /home/$USER/incomplete
sudo ln -s /complete/ /home/$USER/complete

sudo swapon --show
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile

sudo mkswap /swapfile
sudo swapon /swapfile

sudo swapon --show
sudo echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
sudo cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10
echo vm.swappiness=10 | sudo tee -a /etc/sysctl.conf
