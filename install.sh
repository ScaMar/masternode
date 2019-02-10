#####################################################################################
#                    Automatic installation for 3DCoin nodes                        #
#####################################################################################
RED='\033[0;97;41m'
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

Config_Full_Node(){
nodeIpAddress=`curl ifconfig.me/ip`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="externalip=${nodeIpAddress}"
else
  external_ip_line="#externalip=external_IP_goes_here"
fi

rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')

rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')

config="#----
rpcuser=$rpcUserName
rpcpassword=$rpcPassword
rpcallowip=127.0.0.1
#----
listen=1
server=1
daemon=1
maxconnections=64
#----
$external_ip_line
#----
txindex=1
addressindex=1
timestampindex=1
spentindex=1
addnode=206.189.72.203
addnode=206.189.41.191
addnode=165.227.197.115
addnode=167.99.87.86
addnode=159.65.201.222
addnode=159.65.148.226
addnode=165.227.38.214
addnode=159.65.167.79
addnode=159.65.90.101
addnode=128.199.218.139
addnode=174.138.3.33
addnode=159.203.167.75
addnode=138.68.102.67"
}

Config_Full_Node_Multi(){
rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')

rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')

config="#----
\nrpcuser=\"'$rpcUserName'\"
\nrpcpassword=\"'$rpcPassword'\"
\nrpcallowip=127.0.0.1
\n#----
\nlisten=1
\nserver=1
\ndaemon=1
\nmaxconnections=64
\n#----
\nexternalip=\"'$i'\"
\n#----
\ntxindex=1
\naddressindex=1
\ntimestampindex=1
\nspentindex=1
\naddnode=206.189.72.203
\naddnode=206.189.41.191
\naddnode=165.227.197.115
\naddnode=167.99.87.86
\naddnode=159.65.201.222
\naddnode=159.65.148.226
\naddnode=165.227.38.214
\naddnode=159.65.167.79
\naddnode=159.65.90.101
\naddnode=128.199.218.139
\naddnode=174.138.3.33
\naddnode=159.203.167.75
\naddnode=138.68.102.67"
}

Config_Masternode(){
nodeIpAddress=`curl ifconfig.me/ip`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="externalip=${nodeIpAddress}"
else
  external_ip_line="#externalip=external_IP_goes_here"
fi

rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')

rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')

config="#----
rpcuser=$rpcUserName
rpcpassword=$rpcPassword
rpcallowip=127.0.0.1
#----
listen=1
server=1
daemon=1
maxconnections=64
#----
masternode=1
masternodeprivkey=$pv
$external_ip_line
#----
addnode=206.189.72.203
addnode=206.189.41.191
addnode=165.227.197.115
addnode=167.99.87.86
addnode=159.65.201.222
addnode=159.65.148.226
addnode=165.227.38.214
addnode=159.65.167.79
addnode=159.65.90.101
addnode=128.199.218.139
addnode=174.138.3.33
addnode=159.203.167.75
addnode=138.68.102.67"
}

Config_Masternode_Multi(){
nodeIpAddress=`curl ifconfig.me/ip`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="externalip=${nodeIpAddress}"
else
  external_ip_line="#externalip=external_IP_goes_here"
fi

rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')

rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')

config="#----
\nrpcuser=\"'$rpcUserName'\"
\nrpcpassword=\"'$rpcPassword'\"
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
\n#----
\naddnode=206.189.72.203
\naddnode=206.189.41.191
\naddnode=165.227.197.115
\naddnode=167.99.87.86
\naddnode=159.65.201.222
\naddnode=159.65.148.226
\naddnode=165.227.38.214
\naddnode=159.65.167.79
\naddnode=159.65.90.101
\naddnode=128.199.218.139
\naddnode=174.138.3.33
\naddnode=159.203.167.75
\naddnode=138.68.102.67"
}

install_3dcoin_core(){
echo ""
echo  -e "${GREEN} Start Installation 3DCoin core                  ${STD}"
sleep 1
h=$(( RANDOM % 23 + 1 ));
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
echo ""
echo  -e "${GREEN} Building 3dcoin core from source.....     ${STD}"
rm -rf /usr/local/bin/Masternode
cd ~
latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.tar.gz"
wget $link
tar -xvzf $latestrelease.tar.gz
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
./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make || { echo "Error: When Compiling 3Dcoin core" && exit;  }
echo  -e "${GREEN} Make install                              ${STD}"
echo ""			
make install-strip
echo ""
echo  -e "${GREEN} Configure 3dcoin core .....               ${STD}"
cd ~
mkdir ./.3dcoin
echo "$config" > ./.3dcoin/3dcoin.conf
cd ~
cd /usr/local/bin
mkdir Masternode
cd Masternode
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Check-scripts.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Update-scripts.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/UpdateNode.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/clearlog.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/daemon_check.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Version
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/blockcount
chmod 755 daemon_check.sh
chmod 755 UpdateNode.sh
chmod 755 Check-scripts.sh
chmod 755 Update-scripts.sh
chmod 755 clearlog.sh
cd ~
crontab -r
line="@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
*/10 * * * * /usr/local/bin/Masternode/daemon_check.sh
0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */2 * * /usr/local/bin/Masternode/clearlog.sh"
echo "$line" | crontab -u root -
echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
echo ""
cd ~
rm $latestrelease.tar.gz
rm -rf $file 
echo  -e "${GREEN} Rebooting .....               ${STD}"
reboot
}

install_3DCoin_core_Multi(){
echo ""
echo  -e "${GREEN} Connexion Vps ip $i                       ${STD}"
echo ""
sshpass -p $rootpass ssh -p$sshport -o StrictHostKeyChecking=no root@$i '
STD="\033[0;0;39m"
BLUE="\e[1;97;44m"
echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
h=\$(( RANDOM % 23 + 1 ));
configdata=\"'$config'\"
rm -rf /usr/local/bin/Masternode
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
latestrelease=\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"'"\\$"\"tag_name"\\$"\":'"' | sed -E '"'s/.*"\\$"\"([^"\\$"\"]+)"\\$"\".*/\1/'"')
link=\"https://github.com/BlockchainTechLLC/3dcoin/archive/\$latestrelease.tar.gz\"
wget \$link
tar -xvzf \$latestrelease.tar.gz
file=\${latestrelease//[v]/3dcoin-}
cd \$file
./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make || { exit;  }
make install-strip
cd ~
mkdir ./.3dcoin
echo -e \"\$configdata\" > ./.3dcoin/3dcoin.conf
cd ~
cd /usr/local/bin
mkdir Masternode
cd Masternode
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Check-scripts.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Update-scripts.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/UpdateNode.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/clearlog.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/daemon_check.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Version
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/blockcount
chmod 755 daemon_check.sh
chmod 755 UpdateNode.sh
chmod 755 Check-scripts.sh
chmod 755 Update-scripts.sh
chmod 755 clearlog.sh
cd ~
crontab -r
line=\"@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
*/10 * * * * /usr/local/bin/Masternode/daemon_check.sh
0 \$h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */2 * * /usr/local/bin/Masternode/clearlog.sh\"
echo \"\$line\" | crontab -u root -
cd ~
rm \$latestrelease.tar.gz
rm -rf \$file
reboot" > /root/install.sh
chmod 755 install.sh
install="@reboot /root/install.sh"
echo "$install" | crontab -u root -
echo ""
echo  -e "${BLUE}                                                                                      ${STD}"
echo  -e "${BLUE} Script Installation launched on Vps,be patient few minutes and will be ready to use. ${STD}"
echo  -e "${BLUE}                                                                                      ${STD}"
echo ""
reboot'
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
		Config_Full_Node
		install_3dcoin_core
	else
	#### 3Dcoin Multi Nodes installation
		echo ""
		echo ""
		read -p "Same SSH Port and Password for all vps's? (Y/N)" -n 1 -r
		echo ""   # (optional) move to a new line
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo ""
			echo  -e "${GREEN} Enter Vps ip's                    ${STD}"
			echo ""			
			sleep 2
			echo  -e "Please enter your vps ip's: ${RED}(Exemple: 111.111.111.111-222.222.222.222-... ) ${STD}"
			unset ip
			while [ -z ${ip} ]; do
			read -p "IP HERE: " ip
			done
			unset sshport
			while [ -z ${sshport} ]; do
			read -p "SSH Port: " sshport
			done
			unset rootpass
			while [ -z ${rootpass} ]; do
			read -s -p "Password: " rootpass
			done
			echo ""
			vpsip=$(echo $ip | tr "-" " ")
			apt-get update
			yes | apt-get install sshpass
			for i in $vpsip
			do
				Config_Full_Node_Multi
				install_3DCoin_core_Multi
			done
		elif [[ $REPLY =~ ^[Nn]$ ]]; then
			sleep 2
			echo  -e "Please enter your vps's data: 'Host:Password:SSHPort' ${RED}( Exemple: 111.111.111.111:ERdX5h64dSer:22-222.222.222.222:Wz65D232Fty:165-... )${STD}"
			unset ip
			while [ -z ${ip} ]; do
			read -p "DATA HERE: " ip
			done
			apt-get update
			yes | apt-get install sshpass
			data=$(echo $ip | tr "-" " ")
			for ipdata in $data
			do
				vpsdata=$(echo $ipdata | tr ":" "\n")
				declare -a array=($vpsdata)
				i=${array[0]}
				rootpass=${array[1]}
				sshport=${array[2]}
				if [ -z "$rootpass" ] || [ -z "$sshport" ] || [ -z "$i" ]
				then
					echo -e "Please enter a correct vps's data ${RED}( Exemple: 111.111.111.111:ERdX5h64dSer:22 222.222.222.222:Wz65D232Fty:165 ... )${STD}"
				else
					Config_Full_Node_Multi
					install_3DCoin_core_Multi
				fi
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
		unset pv
		while [ -z ${pv} ]; do
		read -p "Please Enter Masternode Private key: " pv
		done
		Config_Masternode
		install_3dcoin_core
	else
	#### 3Dcoin Multi Masternodes installation
		echo ""
		echo ""
		read -p "Same SSH Port and Password for all vps's? (Y/N)" -n 1 -r
		echo ""   # (optional) move to a new line
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo ""
			echo  -e "${GREEN} Enter Vps ip's                    ${STD}"
			echo ""			
			sleep 2
			echo  -e "Please enter your vps ip's: ${RED}(Exemple: 111.111.111.111-222.222.222.222-... ) ${STD}"
			unset ip
			while [ -z ${ip} ]; do
			read -p "IP HERE: " ip
			done
			unset sshport
			while [ -z ${sshport} ]; do
			read -p "SSH Port: " sshport
			done
			unset rootpass
			while [ -z ${rootpass} ]; do
			read -s -p "Password: " rootpass
			done
			echo ""
			vpsip=$(echo $ip | tr "-" " ")
			apt-get update
			yes | apt-get install sshpass
			for i in $vpsip
			do
	            echo ""
	            echo  -e "${GREEN} Masternode Private key ${STD}"
				unset pv
				while [ -z ${pv} ]; do
				read -p "Please Enter Masternode Private key: " pv
				done
				Config_Masternode_Multi
				install_3DCoin_core_Multi
			done
		elif [[ $REPLY =~ ^[Nn]$ ]]; then
			sleep 2
			echo  -e "Please enter your vps's data: 'Host:Password:SSHPort' ${RED}( Exemple: 111.111.111.111:ERdX5h64dSer:22-222.222.222.222:Wz65D232Fty:165-... )${STD}"
			unset ip
			while [ -z ${ip} ]; do
			read -p "DATA HERE: " ip
			done
			apt-get update
			yes | apt-get install sshpass
			data=$(echo $ip | tr "-" " ")
			for ipdata in $data
			do
				vpsdata=$(echo $ipdata | tr ":" "\n")
				declare -a array=($vpsdata)
				i=${array[0]}
				rootpass=${array[1]}
				sshport=${array[2]}
				if [ -z "$rootpass" ] || [ -z "$sshport" ] || [ -z "$i" ]
				then
					echo -e "Please enter a correct vps's data ${RED}( Exemple: 111.111.111.111:ERdX5h64dSer:22 222.222.222.222:Wz65D232Fty:165 ... )${STD}"
				else
					echo ""
					echo  -e "${GREEN} Masternode Private key ${STD}"
					unset pv
					while [ -z ${pv} ]; do
					read -p "Please Enter Masternode Private key: " pv
					done
					Config_Masternode_Multi
					install_3DCoin_core_Multi
				fi
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
