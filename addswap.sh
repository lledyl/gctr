#!/bin/bash/
sudo swapon --show
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile

sudo mkswap /swapfile
sudo swapon /swapfile

sudo swapon --show
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
/swapfile swap swap defaults 0 0
cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" >> /etc/sysctl.conf
