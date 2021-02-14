#! /bin/bash
printf "Installing RDP Be Patience... " >&2
{
sudo useradd -m COLAB
sudo adduser COLAB sudo
echo 'COLAB:9061' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
curl https://raw.githubusercontent.com/lledyl/gctr/master/install2transmission.sh | sudo bash

sudo apt-get update
sudo apt-get -y install unzip
sudo apt-get -y install nano
sudo apt-get -y install vlc
sudo apt-get -y install bmon
sudo apt-get -y install screen
sudo apt-get -y install cron
curl https://rclone.org/install.sh | sudo bash

sudo apt install gdebi
wget https://download2.tixati.com/download/tixati_2.81-1_amd64.deb | https://download2.tixati.com/download/tixati_2.81-1_amd64.deb

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

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
sudo apt install apt-transport-https curl gnupg
sudo apt update
sudo apt install brave-browser
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y 
sudo adduser COLAB chrome-remote-desktop

ln -s /session/ /home/COLAB/Desktop/session
ln -s /completed/ /home/COLAB/Desktop/completed

} &> /dev/null &&
printf "\nSetup Complete " >&2 ||
printf "\nError Occured " >&2
printf '\nCheck https://remotedesktop.google.com/headless  Copy Command Of Debian Linux And Paste Down\n'
read -p "Paste Here: " CRP
su - COLAB -c """$CRP"""
printf 'Check https://remotedesktop.google.com/access/ \n\n'
if sudo apt-get upgrade &> /dev/null
then
    printf "\n\nUpgrade Completed " >&2
else
    printf "\n\nError Occured " >&2
fi
