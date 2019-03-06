#!/bin/bash

# Color constants
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


# This script is responsible for the first stage in setting the system up to use and install p5-central-hub

echo "Checking if user is root..."
if [ "$EUID" -ne 0 ]
  then echo -e "[ ${RED}FAIL${NC} ] Please run script as root"
  exit
fi

echo -e "[  ${GREEN}OK${NC}  ] User is root"

echo "Checking internet connection..."
¨
ping -q -w 1 -c 1 google.com > /dev/null

# Check internet
if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] Internet connection is up"
else
  echo -e "[ ${RED}FAIL${NC} ] Internet connection is down" >&2
  exit 1
fi

echo "Initializing pacman keys..."

pacman-key --init

# Check if pacman-key ran successfully
if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] pacman keys initialized successfully"
else
  echo -e "[ ${RED}FAIL${NC} ] pacman keys did not initialize successfully" >&2
  exit 1
fi

echo "Populating pacman keys..."

pacman-key --populate archlinuxarm

# Check if pacman-key ran successfully
if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] pacman keys populated successfully"
else
  echo -e "[ ${RED}FAIL${NC} ] pacman keys did not populate successfully" >&2
  exit 1
fi

#Update system
echo "Updating system..."

pacman -Suy --noconfirm

# Check if pacman ran successfully
if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] Updated system successfully"
else
  echo -e "[ ${RED}FAIL${NC} ] System update failed" >&2
  exit 1
fi

echo "Installing packages..."

pacman -Suy --noconfirm git wget hostapd dnsmasq create_ap apache mysql php php-apache

# Check if pacman ran successfully
if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] Packages installed successfully"
else
  echo -e "[ ${RED}FAIL${NC} ] Package install failed" >&2
  exit 1
fi

echo "Downloading hotspot config..."

wget https://raw.githubusercontent.com/mads256c/p5-central-hub-setup/master/create_ap.conf

# Check if wget downloaded config
if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] Hotspot config downloaded successfully"
else
  echo -e "[ ${RED}FAIL${NC} ] Hotspot config download failed" >&2
  exit 1
fi

echo "Copying downloaded hotspot config to the right location..."

cp create_ap.conf /etc/create_ap.conf

if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] Hotspot config copy succeeded"
else
  echo -e "[ ${RED}FAIL${NC} ] Hotspot config copy failed" >&2
  exit 1
fi

echo "Installing MySQLl..."

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] MySQL installation succeeded"
else
  echo -e "[ ${RED}FAIL${NC} ] MySQL installation failed" >&2
  exit 1
fi

echo "Executing mysql_secure_installation..."

mysql_secure_installation

if [ $? -eq 0 ]
then
  echo -e "[  ${GREEN}OK${NC}  ] MySQL secure installation succeeded"
else
  echo -e "[ ${RED}FAIL${NC} ] MySQL secure installation failed" >&2
  exit 1
fi


#systemctl enable create_ap