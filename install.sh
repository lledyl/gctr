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
wget https://gist.githubusercontent.com/pawelszydlo/e2e1fc424f2c9d306f3a/raw/c26087d4b4f696bd373b02c0e294fb92dec1039a/transmission_remove_finished.sh -O transmission_remove_finished.sh
mv transmission_remove_finished.sh .clean_transmission.sh


echo "sudo nano /etc/transmission-daemon/settings.json" >> help_commmands.txt
echo "~/flexget/bin/flexget --test execute" >> help_commmands.txt
echo "sudo service transmission-daemon start stop restart" >> help_commmands.txt
echo "find /dir -type d -empty -print -delete" >> help_commmands.txt

crontab -l > mycron
echo "* * * * * sh /home/$USER/upload.sh" >> mycron
echo "#*/30 * * * * ~/flexget/bin/flexget execute" >> mycron
echo "* * * * * sudo chown -R $USER:$USER /completed/*" >> mycron
echo "*/15 * * * * sh .clean_transmission.sh" >> mycron
echo "#@reboot rm -r /session/*" >> mycron
crontab mycron
rm mycron

shopt -s expand_aliases
alias upload='sh /home/$USER/upload.sh'
alias flextest='~/flexget/bin/flexget --test execute'
alias flexget='~/flexget/bin/flexget execute'
alias esettings='sudo nano /etc/transmission-daemon/settings.json'
alias tstart='sudo service transmission-daemon start'
alias tstop='sudo service transmission-daemon stop'
alias trestart='sudo service transmission-daemon restart'
alias addswap='curl https://raw.githubusercontent.com/lledyl/gctr/master/addswap.sh | sudo bash'

sudo mkdir /completed
sudo mkdir /session
sudo chmod -R 777 /completed
sudo chmod -R 777 /session
sudo chown -R $USER:$USER /completed
sudo chown -R $USER:$USER /session
sudo mkdir /completed/video_files_only
cd /completed/video_files_only
sudo touch .deletemeifyoucan
sudo chattr +i .deletemeifyoucan
cd $home
