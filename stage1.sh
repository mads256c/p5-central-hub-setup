#!/bin/bash
echo "Checking if user is root..."
if [ "$EUID" -ne 0 ]
  then echo "[ FAIL ] Please run as root"
  exit
fi

echo "[ OK ] User is root"

echo "Initializing pacman keys..."

pacman-key --init

# Check if pacman-key ran successfully
if [ $? -eq 0 ]
then
  echo "[ OK ] pacman keys initialized sucessfully"
else
  echo "[ FAIL ] pacman keys did not initialize sucessfully" >&2
  exit 1
fi

pacman-key --populate archlinuxarm

echo "[ OK ] pacman keys initialized"

#Update system
echo "Updating System..."

pacman -Suy --noconfirm

echo "Installing packages"

pacman -Suy --noconfirm git wget hostapd dnsmasq create_ap apache mysql php

wget https://raw.githubusercontent.com/mads256c/p5-central-hub-setup/master/create_ap.conf

cp create_ap.conf /etc/create_ap.conf

systemctl 