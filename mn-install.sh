#!/usr/bin/env bash
#
# Download and Run
# wget https://raw.githubusercontent.com/muusic/mn-install-script/master/mn-install.sh
# chmod u+x mn-install.sh
# .mn-install.sh

echo "Muusic Coin Masternode Installer"
echo " "
echo " "
echo "Masternode Private Key GENKEY: "
read GENKEY

echo "VPS IP ADDRESS: "
read VPSIP



echo " "
echo "--------------------------------"
echo "| Installing required packages |"
echo "--------------------------------"
sudo apt-get install -y build-essential \
    libtool autotools-dev autoconf pkg-config \
    libssl-dev libboost-all-dev libzmq5-dev \
    libevent-pthreads-2.0-5 libminiupnpc-dev

cd

echo " "

if [ -d ~/.muusic ]
then
echo "---------------------------------"
echo "| Data directory already exists |"
echo " --------------------------------"

else
 
echo "-------------------------"
echo "| Making data directory |"
echo "-------------------------"

mkdir .muusic
fi

echo " "


configFile=".muusic/muusic.conf"

touch $configFile

rpcuser=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo "rpcuser="$rpcuser >> $configFile
rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo "rpcpassword="$rpcpassword >> $configFile
echo "rpcallowip=127.0.0.1" >> $configFile
echo "daemon=1" >> $configFile
echo "masternodeprivkey="$GENKEY >> $configFile
echo "masternode=1" >> $configFile


echo " "
echo " "
echo "|-----------------------------------|" 
echo "|-----------------------------------|"
echo "| Downloading Muusic binaries       |"
echo "| if they are not present.          |"                  
echo "|-----------------------------------|"
echo "|-----------------------------------|" 
echo " "
echo " "

if [ -e muusicd ] && [ -e muusic-cli ] 
then
echo "-------------------------------"
echo "| Muusic is already installed |"
echo "-------------------------------"

else

wget https://github.com/muusic/muusic/releases/download/v1.0.0/Muusic-Linux-GUI.tar.gz
tar -xvf Muusic-Linux-GUI.tar.gz
rm Muusic-Linux-GUI.tar.gz
fi

echo " "
echo " "
echo "|-----------------------------|" 
echo "|-----------------------------|"
echo "| Check Node Status:          |"           
echo "| ./muusic-cli getinfo        |"
echo "|-----------------------------|"
echo " "
./muusicd -daemon
