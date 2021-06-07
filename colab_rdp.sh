#! /bin/bash
printf "Installing RDP Be Patience... " >&2
{
sudo useradd -m lledyl
sudo adduser lledyl sudo
echo 'lledyl:temp1234' | sudo chpasswd
sudo sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd


sudo apt-get -y update 
sudo apt-get -y upgrade

sudo apt-get -y install unzip
sudo apt-get -y install nano
sudo apt-get -y install vlc



wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken


sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base

sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

sudo apt install --assume-yes xscreensaver

sudo systemctl disable lightdm.service


wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y 
sudo adduser lledyl chrome-remote-desktop

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
