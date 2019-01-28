#####################################################################################
#                    Automatic installation for 3DCoin nodes                        #
#####################################################################################
EDITOR=vim
RED='\033[0;41;30m'
STD='\033[0;0;39m'
GREEN='\e[1;97;42m'
BLUE='\e[1;97;44m'

pause(){
  read -p "Press [Enter] key to continue - Press [CRTL+C] key to Exit..." fackEnterKey
}

show_menus() {
	clear
	echo   ""	
	echo  -e "\e[1;97;44m 3 D C O I N  N O D E S  A U T O  I N S T A L L ${STD}"
	echo   ""
	echo "1. Install Node"
	echo "2. Install Masternode"
	echo "3. Install Primenode"
	echo "4. Install Pulsenode"
	echo "5. Exit"
	echo ""
    echo  -e "\e[1;97;41m                                                         ${STD}"
    echo  -e "\e[1;97;41m CAUTION!!:                                              ${STD}"
    echo  -e "\e[1;97;41m For a successful setup, please clear your vps from any  ${STD}"
    echo  -e "\e[1;97;41m previous 3DCoin core installation                       ${STD}"
    echo  -e "\e[1;97;41m                                                         ${STD}"
	echo ""

}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
	
#### 3Dcoin Node installation
1)type="Node"
echo ""
echo  -e "${BLUE} Start Install 3DCoin ${type}                       ${STD}"
echo ""
echo "Do you want to start the 3DCoin ${type} installation?"
pause
echo ""
echo  -e "${GREEN} Single (Local vps) - Multi (Multi vps's)  ${STD}"

PS3='Please enter your choice: '
options=("Install Single ${type}" "Install Multi ${type}")
select opt in "${options[@]}"
do
    case $opt in
        "Install Single ${type}")
             break
           ;;
        "Install Multi ${type}")
             break
           ;;
        *) echo invalid option;;
    esac
done
#### 3Dcoin Single Node installation
if [ "$opt" == "Install Single ${type}" ]; then
echo ""
echo  -e "${GREEN} Get RPC Data                              ${STD}"
sleep 1

unset ip
while [ -z ${ip} ]; do
read -p "Please Enter VPS Ip: " ip
done

unset username
while [ -z ${username} ]; do
read -p "Please Enter RPC User: " username
done

unset pass
while [ -z ${pass} ]; do
read -s -p "Please Enter RPC Password: " pass
echo ""
done
        
config="#----
rpcuser=$username
rpcpassword=$pass
rpcallowip=127.0.0.1
#----
listen=1
server=1
daemon=1
maxconnections=64
#----
externalip=$ip
#----"

echo ""
echo  -e "${GREEN} Install packages.....                     ${STD}"
yes | apt-get update
yes | apt-get install ufw python virtualenv git unzip pv nano htop libwww-perl
echo ""
echo  -e "${GREEN} Firewall/Swapfile setup.....              ${STD}"
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp 
sudo ufw allow 6695/tcp
sudo ufw logging on 
yes | sudo ufw enable 
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab
sleep 2 
echo "Firewall/Swapfile setup successfully"
echo ""
echo  -e "${GREEN} Building 3dcoin core from source.....     ${STD}"
cd ~
latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.zip"
wget $link
unzip $latestrelease.zip
file=${latestrelease//[v]/3dcoin-}
yes | sudo apt-get update 
export LC_ALL=en_US.UTF-8
yes | sudo apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes | sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes | sudo apt-get install software-properties-common 
yes | sudo add-apt-repository ppa:bitcoin/bitcoin 
yes | sudo apt-get update 
yes | sudo apt-get install libdb4.8-dev libdb4.8++-dev 
yes | sudo apt-get install libminiupnpc-dev 
yes | sudo apt-get install libzmq3-dev
sleep 2
echo ""
echo  -e "${GREEN} Compile 3dcoin core .....                 ${STD}"
cd $file
./autogen.sh
./configure --disable-tests --disable-gui-tests --without-gui
make install-strip
echo ""
echo  -e "${GREEN} Configure 3dcoin core .....               ${STD}"
cd ~
mkdir ./.3dcoin
echo "$config" >> ./.3dcoin/3dcoin.conf
cd ~
echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestrelease=\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/')
localrelease=\$(3dcoin-cli -version | awk -F' ' '{print \$NF}' | cut -d \"-\" -f1)
if [ -z \"\$latestrelease\" ] || [ \"\$latestrelease\" == \"\$localrelease\" ]; then
exit;
else
cd ~
localfile=\${localrelease//[v]/3dcoin-}
rm -rf \$localfile
link=\"https://github.com/BlockchainTechLLC/3dcoin/archive/\$latestrelease.zip\"
wget \$link
unzip \$latestrelease.zip
file=\${latestrelease//[v]/3dcoin-}
cd \$file
3dcoin-cli stop
sleep 10
./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;
cd ~
rm \$latestrelease.zip
reboot
fi" >> /usr/local/bin/UpdateNode.sh
cd ~
cd /usr/local/bin
chmod 755 UpdateNode.sh
cd ~
crontab -r
line="@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/UpdateNode.sh"
echo "$line" | crontab -u root -
echo "3DCOIN Configured successfully"
echo ""
cd ~
rm $latestrelease.zip
reboot

else
#### 3Dcoin Multi Nodes installation
echo ""
echo  -e "\e[1;97;44m                                                    ${STD}"
echo  -e "\e[1;97;44m CAUTION!!: You must use root account for all vps's ${STD}"
echo  -e "\e[1;97;44m                                                    ${STD}"
echo ""
echo "Do you want to continue multi ${type} installation?"
pause
echo ""
echo  -e "${GREEN} Enter Vps ip's                            ${STD}"
echo ""
echo  -e "Please enter your vps ip's: \e[1;97;41m( Exemple: 111.111.111.111 222.222.222.222 )${STD}"

unset ip
while [ -z ${ip} ]; do
read -p "IP HERE: " ip
done

apt-get update
yes | apt-get install sshpass

echo ""
echo  -e "${GREEN} RPC Data                                  ${STD}"
read -p "Do you want to use the same rpcuser & rpcpass for all vps)? (Y/N)" -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then

echo ""
echo  -e "${GREEN} Get RPC Data                              ${STD}"
unset username
while [ -z ${username} ]; do
read -p "Please Enter RPC User: " username
done

unset pass
while [ -z ${pass} ]; do
read -s -p "Please Enter RPC Password: " pass
echo ""
done

for i in $ip
do

echo ""
echo  -e "${GREEN} Connexion Vps ip $i                       ${STD}"
echo ""

unset rootpass
while [ -z ${rootpass} ]; do
read -s -p "Please Enter Password Root $i: " rootpass
echo ""
done

config="#----
\nrpcuser=\"'$username'\"
\nrpcpassword=\"'$pass'\"
\nrpcallowip=127.0.0.1
\n#----
\nlisten=1
\nserver=1
\ndaemon=1
\nmaxconnections=64
\n#----
\nexternalip=\"'$i'\"
\n#----"

ssh-keygen -f "/root/.ssh/known_hosts" -R $i
sshpass -p $rootpass ssh -o StrictHostKeyChecking=no root@$i '
echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
configdata=\"'$config'\"
yes | apt-get update
yes | apt-get install ufw python virtualenv git unzip pv nano htop libwww-perl
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp 
sudo ufw allow 6695/tcp
sudo ufw logging on 
yes | sudo ufw enable 
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile
echo \"/swapfile none swap sw 0 0\" >> /etc/fstab
sleep 4
cd ~
sudo git clone https://github.com/BlockchainTechLLC/3dcoin.git
yes | sudo apt-get update 
export LC_ALL=en_US.UTF-8
yes | sudo apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes | sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes | sudo apt-get install software-properties-common 
yes | sudo add-apt-repository ppa:bitcoin/bitcoin 
yes | sudo apt-get update 
yes | sudo apt-get install libdb4.8-dev libdb4.8++-dev 
yes | sudo apt-get install libminiupnpc-dev 
yes | sudo apt-get install libzmq3-dev
sleep 2
cd 3dcoin
./autogen.sh
./configure --disable-tests --disable-gui-tests --without-gui
make install-strip
sleep 2
cd ~
mkdir ./.3dcoin
echo -e \"\$configdata\" >> ./.3dcoin/3dcoin.conf
cd ~
dir=\$( echo \$(find / -type d -name \"3dcoin\") | cut -d\" \" -f1)
echo \"#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestrelease="\\$"\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"'"\\$"\\"\\$"\"tag_name"\\$"\\"\\$"\":'"' | sed -E '"'s/.*"\\$"\\"\\$"\"([^"\\$"\\"\\$"\"]+)"\\$"\\"\\$"\".*/\1/'"') 
localrelease="\\$"\$(3dcoin-cli -version | awk -F'"' '"' '"'{print "\\$"\\"\\$"\$NF}'"' | cut -d "\\$"\"-"\\$"\" -f1)
if [ -z "\\$"\""\\$"\$latestrelease"\\$"\" ] || [ "\\$"\""\\$"\$latestrelease"\\$"\" == "\\$"\""\\$"\$localrelease"\\$"\" ]; then
exit;
else
cd \$dir
git checkout master
make clean
git pull
3dcoin-cli stop
sleep 10
make install-strip || { ./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;  }
reboot
fi\" >> /usr/local/bin/UpdateNode.sh
cd ~
cd /usr/local/bin
chmod 755 UpdateNode.sh
cd ~
crontab -r
line=\"@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/UpdateNode.sh\"
echo \"\$line\" | crontab -u root -
sleep 2
reboot" >> /root/install.sh
chmod 755 install.sh
line2="@reboot /root/install.sh"
echo "$line2" | crontab -u root -
reboot'
done

elif [[ $REPLY =~ ^[Nn]$ ]]; then

for i in $ip
do

echo ""
echo  -e "${GREEN} Get RPC Data for IP $i                    ${STD}"

unset username
while [ -z ${username} ]; do
read -p "Please Enter RPC User: " username
done

unset pass
while [ -z ${pass} ]; do
read -s -p "Please Enter RPC Password: " pass
echo ""
done

echo ""
echo  -e "${GREEN} Connexion Vps ip $i                       ${STD}"
echo ""

unset rootpass
while [ -z ${rootpass} ]; do
read -s -p "Please Enter Password Root $i: " rootpass
echo ""
done

config="#----
\nrpcuser=\"'$username'\"
\nrpcpassword=\"'$pass'\"
\nrpcallowip=127.0.0.1
\n#----
\nlisten=1
\nserver=1
\ndaemon=1
\nmaxconnections=64
\n#----
\nexternalip=\"'$i'\"
\n#----"

ssh-keygen -f "/root/.ssh/known_hosts" -R $i
sshpass -p $rootpass ssh -o StrictHostKeyChecking=no root@$i '
echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
configdata=\"'$config'\"
yes | apt-get update
yes | apt-get install ufw python virtualenv git unzip pv nano htop libwww-perl
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp 
sudo ufw allow 6695/tcp
sudo ufw logging on 
yes | sudo ufw enable 
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile
echo \"/swapfile none swap sw 0 0\" >> /etc/fstab
sleep 4
cd ~
sudo git clone https://github.com/BlockchainTechLLC/3dcoin.git
yes | sudo apt-get update 
export LC_ALL=en_US.UTF-8
yes | sudo apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes | sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes | sudo apt-get install software-properties-common 
yes | sudo add-apt-repository ppa:bitcoin/bitcoin 
yes | sudo apt-get update 
yes | sudo apt-get install libdb4.8-dev libdb4.8++-dev 
yes | sudo apt-get install libminiupnpc-dev 
yes | sudo apt-get install libzmq3-dev
sleep 2
cd 3dcoin
./autogen.sh
./configure --disable-tests --disable-gui-tests --without-gui
make install-strip
sleep 2
cd ~
mkdir ./.3dcoin
echo -e \"\$configdata\" >> ./.3dcoin/3dcoin.conf
cd ~
dir=\$( echo \$(find / -type d -name \"3dcoin\") | cut -d\" \" -f1)
echo \"#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestrelease="\\$"\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"'"\\$"\\"\\$"\"tag_name"\\$"\\"\\$"\":'"' | sed -E '"'s/.*"\\$"\\"\\$"\"([^"\\$"\\"\\$"\"]+)"\\$"\\"\\$"\".*/\1/'"') 
localrelease="\\$"\$(3dcoin-cli -version | awk -F'"' '"' '"'{print "\\$"\\"\\$"\$NF}'"' | cut -d "\\$"\"-"\\$"\" -f1)
if [ -z "\\$"\""\\$"\$latestrelease"\\$"\" ] || [ "\\$"\""\\$"\$latestrelease"\\$"\" == "\\$"\""\\$"\$localrelease"\\$"\" ]; then
exit;
else
cd \$dir
git checkout master
make clean
git pull
3dcoin-cli stop
sleep 10
make install-strip || { ./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;  }
reboot
fi\" >> /usr/local/bin/UpdateNode.sh
cd ~
cd /usr/local/bin
chmod 755 UpdateNode.sh
cd ~
crontab -r
line=\"@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/UpdateNode.sh\"
echo \"\$line\" | crontab -u root -
sleep 2
reboot" >> /root/install.sh
chmod 755 install.sh
line2="@reboot /root/install.sh"
echo "$line2" | crontab -u root -
reboot'
done

else
exit;
fi

fi

exit 0;;

#### 3Dcoin Masternode installation
2) type="Masternode"
echo ""
echo  -e "${BLUE} Start Install 3DCoin ${type}                       ${STD}"
echo ""
echo "Do you want to start the 3DCoin ${type} installation?"
pause

echo ""
echo  -e "${GREEN} Single (Local vps) - Multi (Multi vps's)  ${STD}"

PS3='Please enter your choice: '
options=("Install Single ${type}" "Install Multi ${type}")
select opt in "${options[@]}"
do
    case $opt in
        "Install Single ${type}")
             break
           ;;
        "Install Multi ${type}")
             break
           ;;
        *) echo invalid option;;
    esac
done
#### 3Dcoin Single Masternode installation
if [ "$opt" == "Install Single ${type}" ]; then
echo  -e "${GREEN} Get RPC Data                      ${STD}"
sleep 1

unset ip
while [ -z ${ip} ]; do
read -p "Please Enter VPS Ip: " ip
done

unset username
while [ -z ${username} ]; do
read -p "Please Enter RPC User: " username
done

unset pass
while [ -z ${pass} ]; do
read -s -p "Please Enter RPC Password: " pass
echo ""
done

unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done
		
config="#----
rpcuser=$username
rpcpassword=$pass
rpcallowip=127.0.0.1
#----
listen=1
server=1
daemon=1
maxconnections=64
#----
masternode=1
masternodeprivkey=$pv
externalip=$ip
#----"

echo ""
echo  -e "${GREEN} Install packages.....                     ${STD}"
yes | apt-get update
yes | apt-get install ufw python virtualenv git unzip pv nano htop libwww-perl
echo ""
echo  -e "${GREEN} Firewall/Swapfile setup.....              ${STD}"
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp 
sudo ufw allow 6695/tcp
sudo ufw logging on 
yes | sudo ufw enable 
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab
sleep 2 
echo "Firewall/Swapfile setup successfully"
echo ""
echo  -e "${GREEN} Building 3dcoin core from source.....     ${STD}"
cd ~
latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.zip"
wget $link
unzip $latestrelease.zip
file=${latestrelease//[v]/3dcoin-}
yes | sudo apt-get update 
export LC_ALL=en_US.UTF-8
yes | sudo apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes | sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes | sudo apt-get install software-properties-common 
yes | sudo add-apt-repository ppa:bitcoin/bitcoin 
yes | sudo apt-get update 
yes | sudo apt-get install libdb4.8-dev libdb4.8++-dev 
yes | sudo apt-get install libminiupnpc-dev 
yes | sudo apt-get install libzmq3-dev
sleep 2
echo ""
echo  -e "${GREEN} Compile 3dcoin core .....                 ${STD}"
cd $file
./autogen.sh
./configure --disable-tests --disable-gui-tests --without-gui
make install-strip
echo ""
echo  -e "${GREEN} Configure 3dcoin core .....               ${STD}"
cd ~
mkdir ./.3dcoin
echo "$config" >> ./.3dcoin/3dcoin.conf
cd ~
echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestrelease=\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/')
localrelease=\$(3dcoin-cli -version | awk -F' ' '{print \$NF}' | cut -d \"-\" -f1)
if [ -z \"\$latestrelease\" ] || [ \"\$latestrelease\" == \"\$localrelease\" ]; then
exit;
else
cd ~
localfile=\${localrelease//[v]/3dcoin-}
rm -rf \$localfile
link=\"https://github.com/BlockchainTechLLC/3dcoin/archive/\$latestrelease.zip\"
wget \$link
unzip \$latestrelease.zip
file=\${latestrelease//[v]/3dcoin-}
cd \$file
3dcoin-cli stop
sleep 10
./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;
cd ~
rm \$latestrelease.zip
reboot
fi" >> /usr/local/bin/UpdateNode.sh
cd ~
cd /usr/local/bin
chmod 755 UpdateNode.sh
cd ~
crontab -r
line="@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/UpdateNode.sh"
echo "$line" | crontab -u root -
echo "3DCOIN Configured successfully"
echo ""
cd ~
rm $latestrelease.zip
reboot

else
#### 3Dcoin Multi Masternodes installation
echo ""
echo  -e "\e[1;97;44m                                                    ${STD}"
echo  -e "\e[1;97;44m CAUTION!!: You must use root account for all vps's ${STD}"
echo  -e "\e[1;97;44m                                                    ${STD}"
echo ""
echo "Do you want to continue multi ${type} installation?"
pause

echo ""
echo  -e "${GREEN} Enter Vps ip's                            ${STD}"
echo ""
echo  -e "Please enter your vps ip's: \e[1;97;41m( Exemple: 111.111.111.111 222.222.222.222 )${STD}"

unset ip
while [ -z ${ip} ]; do
read -p "IP HERE: " ip
done

apt-get update
yes | apt-get install sshpass

echo ""
echo  -e "${GREEN} RPC Data                                  ${STD}"
read -p "Do you want to use the same rpcuser & rpcpass for all vps)? (Y/N)" -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then

echo ""
echo  -e "${GREEN} Get RPC Data                              ${STD}"
unset username
while [ -z ${username} ]; do
read -p "Please Enter RPC User: " username
done

unset pass
while [ -z ${pass} ]; do
read -s -p "Please Enter RPC Password: " pass
echo ""
done

for i in $ip
do

echo ""
echo  -e "${GREEN} Connexion Vps ip $i                       ${STD}"
echo ""

unset rootpass
while [ -z ${rootpass} ]; do
read -s -p "Please Enter Password Root $i: " rootpass
echo ""
done

echo ""
echo  -e "${GREEN} Masternode Private Key $i                       ${STD}"
unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done

config="#----
\nrpcuser=\"'$username'\"
\nrpcpassword=\"'$pass'\"
\nrpcallowip=127.0.0.1
\n#----
\nlisten=1
\nserver=1
\ndaemon=1
\nmaxconnections=64
\n#----
\nmasternode=1
\nmasternodeprivkey=\"'$pv'\"
\nexternalip=\"'$i'\"
\n#----"

ssh-keygen -f "/root/.ssh/known_hosts" -R $i
sshpass -p $rootpass ssh -o StrictHostKeyChecking=no root@$i '
echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
configdata=\"'$config'\"
yes | apt-get update
yes | apt-get install ufw python virtualenv git unzip pv nano htop libwww-perl
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp 
sudo ufw allow 6695/tcp
sudo ufw logging on 
yes | sudo ufw enable 
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile
echo \"/swapfile none swap sw 0 0\" >> /etc/fstab
sleep 4
cd ~
sudo git clone https://github.com/BlockchainTechLLC/3dcoin.git
yes | sudo apt-get update 
export LC_ALL=en_US.UTF-8
yes | sudo apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes | sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes | sudo apt-get install software-properties-common 
yes | sudo add-apt-repository ppa:bitcoin/bitcoin 
yes | sudo apt-get update 
yes | sudo apt-get install libdb4.8-dev libdb4.8++-dev 
yes | sudo apt-get install libminiupnpc-dev 
yes | sudo apt-get install libzmq3-dev
sleep 2
cd 3dcoin
./autogen.sh
./configure --disable-tests --disable-gui-tests --without-gui
make install-strip
sleep 2
cd ~
mkdir ./.3dcoin
echo -e \"\$configdata\" >> ./.3dcoin/3dcoin.conf
cd ~
dir=\$( echo \$(find / -type d -name \"3dcoin\") | cut -d\" \" -f1)
echo \"#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestrelease="\\$"\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"'"\\$"\\"\\$"\"tag_name"\\$"\\"\\$"\":'"' | sed -E '"'s/.*"\\$"\\"\\$"\"([^"\\$"\\"\\$"\"]+)"\\$"\\"\\$"\".*/\1/'"') 
localrelease="\\$"\$(3dcoin-cli -version | awk -F'"' '"' '"'{print "\\$"\\"\\$"\$NF}'"' | cut -d "\\$"\"-"\\$"\" -f1)
if [ -z "\\$"\""\\$"\$latestrelease"\\$"\" ] || [ "\\$"\""\\$"\$latestrelease"\\$"\" == "\\$"\""\\$"\$localrelease"\\$"\" ]; then
exit;
else
cd \$dir
git checkout master
make clean
git pull
3dcoin-cli stop
sleep 10
make install-strip || { ./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;  }
reboot
fi\" >> /usr/local/bin/UpdateNode.sh
cd ~
cd /usr/local/bin
chmod 755 UpdateNode.sh
cd ~
crontab -r
line=\"@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/UpdateNode.sh\"
echo \"\$line\" | crontab -u root -
sleep 2
reboot" >> /root/install.sh
chmod 755 install.sh
line2="@reboot /root/install.sh"
echo "$line2" | crontab -u root -
reboot'
done

elif [[ $REPLY =~ ^[Nn]$ ]]; then

for i in $ip
do

echo ""
echo  -e "${GREEN} Get RPC Data for IP $i                    ${STD}"

unset username
while [ -z ${username} ]; do
read -p "Please Enter RPC User: " username
done

unset pass
while [ -z ${pass} ]; do
read -s -p "Please Enter RPC Password: " pass
echo ""
done

echo ""
echo  -e "${GREEN} Connexion Vps ip $i                       ${STD}"
echo ""

unset rootpass
while [ -z ${rootpass} ]; do
read -s -p "Please Enter Password Root $i: " rootpass
echo ""
done

echo ""
echo  -e "${GREEN} Masternode Private Key $i                       ${STD}"
unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done

config="#----
\nrpcuser=\"'$username'\"
\nrpcpassword=\"'$pass'\"
\nrpcallowip=127.0.0.1
\n#----
\nlisten=1
\nserver=1
\ndaemon=1
\nmaxconnections=64
\n#----
\nmasternode=1
\nmasternodeprivkey=\"'$pv'\"
\nexternalip=\"'$i'\"
\n#----"

ssh-keygen -f "/root/.ssh/known_hosts" -R $i
sshpass -p $rootpass ssh -o StrictHostKeyChecking=no root@$i '
echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
configdata=\"'$config'\"
yes | apt-get update
yes | apt-get install ufw python virtualenv git unzip pv nano htop libwww-perl
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp 
sudo ufw allow 6695/tcp
sudo ufw logging on 
yes | sudo ufw enable 
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile
echo \"/swapfile none swap sw 0 0\" >> /etc/fstab
sleep 4
cd ~
sudo git clone https://github.com/BlockchainTechLLC/3dcoin.git
yes | sudo apt-get update 
export LC_ALL=en_US.UTF-8
yes | sudo apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes | sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes | sudo apt-get install software-properties-common 
yes | sudo add-apt-repository ppa:bitcoin/bitcoin 
yes | sudo apt-get update 
yes | sudo apt-get install libdb4.8-dev libdb4.8++-dev 
yes | sudo apt-get install libminiupnpc-dev 
yes | sudo apt-get install libzmq3-dev
sleep 2
cd 3dcoin
./autogen.sh
./configure --disable-tests --disable-gui-tests --without-gui
make install-strip
sleep 2
cd ~
mkdir ./.3dcoin
echo -e \"\$configdata\" >> ./.3dcoin/3dcoin.conf
cd ~
dir=\$( echo \$(find / -type d -name \"3dcoin\") | cut -d\" \" -f1)
echo \"#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestrelease="\\$"\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"'"\\$"\\"\\$"\"tag_name"\\$"\\"\\$"\":'"' | sed -E '"'s/.*"\\$"\\"\\$"\"([^"\\$"\\"\\$"\"]+)"\\$"\\"\\$"\".*/\1/'"') 
localrelease="\\$"\$(3dcoin-cli -version | awk -F'"' '"' '"'{print "\\$"\\"\\$"\$NF}'"' | cut -d "\\$"\"-"\\$"\" -f1)
if [ -z "\\$"\""\\$"\$latestrelease"\\$"\" ] || [ "\\$"\""\\$"\$latestrelease"\\$"\" == "\\$"\""\\$"\$localrelease"\\$"\" ]; then
exit;
else
cd \$dir
git checkout master
make clean
git pull
3dcoin-cli stop
sleep 10
make install-strip || { ./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;  }
reboot
fi\" >> /usr/local/bin/UpdateNode.sh
cd ~
cd /usr/local/bin
chmod 755 UpdateNode.sh
cd ~
crontab -r
line=\"@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/UpdateNode.sh\"
echo \"\$line\" | crontab -u root -
sleep 2
reboot" >> /root/install.sh
chmod 755 install.sh
line2="@reboot /root/install.sh"
echo "$line2" | crontab -u root -
reboot'
done

else
exit;
fi

fi

exit 0;;

#### 3Dcoin Primenode installation
3)type="Primenode"
echo ""
echo  -e "${BLUE} Primenodes are concerned with hosting and running the DAPPs whether they are  ${STD}"
echo  -e "${BLUE} meant for Districts or an external service (web site etc ...),facilitating    ${STD}"
echo  -e "${BLUE} user-to-Dapp access by functioning as a Dapp Name System  (DNS), storing the  ${STD}"
echo  -e "${BLUE} DAPP chain and mining DAPP blocks, and all side chains created on the 3DCoin  ${STD}"
echo  -e "${BLUE} platform by the users. also runs the network status module. DAPPs are stored  ${STD}"
echo  -e "${BLUE} in data structures called Data Capsules, each one is referenced to a block in ${STD}"
echo  -e "${BLUE} the DAPP chain by a Dapp token.                                               ${STD}"
echo  -e "${BLUE}-------------------------------------------------------------------------------${STD}"
echo  -e "${BLUE} For more informations you can visite: https://3dcoin.io                       ${STD}"
echo  -e "${BLUE}-------------------------------------------------------------------------------${STD}"
echo ""
echo "Coming soon in next updates ...."
echo ""

exit 0;;

#### 3Dcoin Pulsenode installation
4)type="Pulsenode"
echo ""
echo  -e "${BLUE} Pulsenodes on the other hand, are dedicated to validating Districts object    ${STD}" 
echo  -e "${BLUE} tokens,hosting the Real time objects token list, the object chain and its     ${STD}"
echo  -e "${BLUE} mining, and the real time events in the Districts 3D world, thus serving as a ${STD}" 
echo  -e "${BLUE} bridge between clients and Prime nodes which run Dapps (3D world clients are  ${STD}"
echo  -e "${BLUE} not connected to Prime nodes directly). Runs the network status module.       ${STD}"
echo  -e "${BLUE}-------------------------------------------------------------------------------${STD}"
echo  -e "${BLUE} For more informations you can visite: https://3dcoin.io                       ${STD}"
echo  -e "${BLUE}-------------------------------------------------------------------------------${STD}"
echo ""
echo "Coming soon in next updates ...."
echo ""
exit 0;;

5) exit 0;;

*) echo -e "${RED}Invalid option...${STD}" && sleep 2
esac
}
  
while true
do
 
show_menus
read_options 
done
