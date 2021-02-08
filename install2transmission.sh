sudo mkdir /completed2
sudo mkdir /session2
sudo chmod -R 777 /completed2
sudo chmod -R 777 /session2
sudo chown -R $USER:$USER /completed2
sudo chown -R $USER:$USER /session2
sudo mkdir /completed2/video_files_only
cd /completed2/video_files_only
sudo touch .deletemeifyoucan
sudo chattr +i .deletemeifyoucan
cd $home

sudo cp /usr/bin/transmission-daemon /usr/bin/transmission-daemon2
sudo cp /etc/init.d/transmission-daemon /etc/init.d/transmission-daemon2
sudo cp -a /var/lib/transmission-daemon /var/lib/transmission-daemon2
sudo cp -a /etc/transmission-daemon /etc/transmission-daemon2
sudo cp /etc/default/transmission-daemon /etc/default/transmission-daemon2
sudo chmod -R 777 /usr/bin/transmission-daemon2
sudo chmod -R 777 /etc/init.d/transmission-daemon2
sudo chmod -R 777 /var/lib/transmission-daemon2
sudo chmod -R 777 /etc/transmission-daemon2
sudo chmod -R 777 /etc/default/transmission-daemon2

sudo ln -sf /etc/transmission-daemon2/settings.json /var/lib/transmission-daemon2/info/settings.json

sudo sed -i 's/transmission-daemon/transmission-daemon2/g' /etc/init.d/transmission-daemon2

sudo sed -i 's/completed/completed2/g' /etc/transmission-daemon2/settings.json
sudo sed -i 's/session/session2/g' /etc/transmission-daemon2/settings.json
sudo sed -i 's/9091/9092/g' /etc/transmission-daemon2/settings.json
sudo sed -i 's/51413/51412/g' /etc/transmission-daemon2/settings.json

sudo sed -i 's/transmission-daemon/transmission-daemon2/g' /etc/default/transmission-daemon2

sudo update-rc.d transmission-daemon2 defaults
