#!/bin/bash/
#Install on Ubuntu 20 LTS

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
pip install transmission-rpc -U
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
echo "* * * * * sudo chown -R $USER:$USER /home/$USER/Downloads/completed/*" >> mycron
echo "*/15 * * * * sh .clean_transmission.sh" >> mycron
echo "#@reboot rm -r /home/$USER/Downloads/session/*" >> mycron
crontab mycron
rm mycron

sudo mkdir /home/$USER/Downloads
sudo mkdir /home/$USER/Downloads/completed
sudo mkdir /home/$USER/Downloads/session
sudo chmod -R 777 /home/$USER/Downloads/completed
sudo chmod -R 777 /home/$USER/Downloads/session
sudo chown -R $USER:$USER /home/$USER/Downloads/completed
sudo chown -R $USER:$USER /home/$USER/Downloads/session
sudo mkdir /home/$USER/Downloads/completed/video_files_only
cd /home/$USER/Downloads/completed/video_files_only
sudo touch .deletemeifyoucan
sudo chattr +i .deletemeifyoucan
cd $home
