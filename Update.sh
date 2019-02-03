#####################################################################################
#                           Update 3DCoin Core V 0.14 	                            #
#####################################################################################
RED='\033[0;97;41m'
STD='\033[0;0;39m'
GREEN='\e[1;97;42m'
BLUE='\e[1;97;44m'

show_menus() {
	clear
	echo ""	
	echo  -e "${BLUE} U P D A T E  3 D C O I N  M A S T E R N O D E ${STD}"
	echo ""
	echo "1. Update Masternode & Auto-update script"
	echo "2. Update only Auto-update script"
	echo "3. Exit"
	echo ""
    echo  -e "\e[1;97;41m Note!!: Update 3DCoin Core V 0.14 & Update for Auto-update   ${STD}"
	echo ""
}

Update_Masternode_And_Script_Single() {
	echo ""
	h=$(( RANDOM % 23 + 1 ));
	echo  -e "${BLUE} Start ${Update}                    ${STD}"
	rm -f /usr/local/bin/check.sh
	rm -f /usr/local/bin/update.sh
	rm -f /usr/local/bin/UpdateNode.sh
	rm -rf /usr/local/bin/Masternode
	echo ""
	cd ~
	echo  -e "${GREEN} Get latest release                ${STD}"
	latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
	link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.tar.gz"
	wget $link
	tar -xvzf $latestrelease.tar.gz
	file=${latestrelease//[Vv]/3dcoin-} 
	echo ""
	echo  -e "${GREEN} Stop Cron                         ${STD}" 
	sudo /etc/init.d/cron stop
	echo ""
	echo  -e "${GREEN} Compiling 3Dcoin core             ${STD}"
	cd $file
	./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make || { echo "Error: When Compiling 3Dcoin core" && exit;  }
	echo  -e "${GREEN} Stop 3Dcoin core                  ${STD}"
	echo ""			
	3dcoin-cli stop
	sleep 10	
	echo  -e "${GREEN} Make install                      ${STD}"
	echo ""			
	make install-strip
	echo ""
	echo  -e "${GREEN} Update crontab                    ${STD}"
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
	echo "Crontab updated successfully"
	echo ""
	echo  -e "${GREEN} Start Cron                        ${STD}"
	sudo /etc/init.d/cron start
	echo ""		
	echo  -e "${GREEN} Update Finished,rebooting server  ${STD}" 
	cd ~
	rm $latestrelease.tar.gz
	rm -rf $file 
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.72.203") -eq 0 ]; then
	echo "addnode=206.189.72.203" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.41.191") -eq 0 ]; then
	echo "addnode=206.189.41.191" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.197.115") -eq 0 ]; then
	echo "addnode=165.227.197.115" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=167.99.87.86") -eq 0 ]; then
	echo "addnode=167.99.87.86" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.201.222") -eq 0 ]; then
	echo "addnode=159.65.201.222" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.148.226") -eq 0 ]; then
	echo "addnode=159.65.148.226" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.38.214") -eq 0 ]; then
	echo "addnode=165.227.38.214" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.167.79") -eq 0 ]; then
	echo "addnode=159.65.167.79" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.90.101") -eq 0 ]; then
	echo "addnode=159.65.90.101" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=128.199.218.139") -eq 0 ]; then
	echo "addnode=128.199.218.139" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=174.138.3.33") -eq 0 ]; then
	echo "addnode=174.138.3.33" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.203.167.75") -eq 0 ]; then
	echo "addnode=159.203.167.75" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=138.68.102.67") -eq 0 ]; then
	echo "addnode=138.68.102.67" >> /root/.3dcoin/3dcoin.conf
	fi	
	reboot
}
Update_Masternode_And_Script_Multi() {
    sshpass -p $rootpass ssh -p$sshport -o StrictHostKeyChecking=no root@$ipserver '
	h=$(( RANDOM % 23 + 1 ));
    rm -f /usr/local/bin/check.sh
    rm -f /usr/local/bin/update.sh
    rm -f /usr/local/bin/UpdateNode.sh
	rm -rf /usr/local/bin/Masternode
	cd ~
	echo "-----------------------------------------------------"
    echo  -e "${GREEN} Git checkout master               ${STD}"
    echo "-----------------------------------------------------"
    latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"'"\\$"\"tag_name"\\$"\":'"' | sed -E '"'s/.*"\\$"\"([^"\\$"\"]+)"\\$"\".*/\1/'"')
	link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.tar.gz"
	wget $link
	tar -xvzf $latestrelease.tar.gz
    file=${latestrelease//[Vv]/3dcoin-}
    echo ""
    echo "-----------------------------------------------------"
    echo  -e "${GREEN} Stop Cron                         ${STD}"
    echo "-----------------------------------------------------"
    sudo /etc/init.d/cron stop
    echo ""
    echo "-----------------------------------------------------"
    echo  -e "${GREEN} Compiling 3Dcoin core             ${STD}"
    echo "-----------------------------------------------------"
    cd $file
	./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make || { echo "Error: When Compiling 3Dcoin core" && exit;  }
    echo ""
    echo "-----------------------------------------------------"
    echo  -e "${GREEN} Stop 3Dcoin core                  ${STD}"
    echo "-----------------------------------------------------"
	3dcoin-cli stop
	sleep 10
    echo ""	
    echo "-----------------------------------------------------"
    echo  -e "${GREEN} Make install                      ${STD}"
    echo "-----------------------------------------------------"	
	make install-strip
    echo ""	
    echo "-----------------------------------------------------"
    echo  -e "${GREEN} Update crontab                    ${STD}"
    echo "-----------------------------------------------------" 
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
0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
*/10 * * * * /usr/local/bin/Masternode/daemon_check.sh
* * */2 * * /usr/local/bin/Masternode/clearlog.sh"
    echo "$line" | crontab -u root -
    echo "Crontab updated successfully"
    echo "" 
    echo "-----------------------------------------------------"
    echo  -e "${GREEN} Update Finished,rebooting server  ${STD}" 
    echo "-----------------------------------------------------"
	cd ~
    rm $latestrelease.tar.gz
	rm -rf $file 
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.72.203") -eq 0 ]; then
	echo "addnode=206.189.72.203" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.41.191") -eq 0 ]; then
	echo "addnode=206.189.41.191" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.197.115") -eq 0 ]; then
	echo "addnode=165.227.197.115" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=167.99.87.86") -eq 0 ]; then
	echo "addnode=167.99.87.86" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.201.222") -eq 0 ]; then
	echo "addnode=159.65.201.222" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.148.226") -eq 0 ]; then
	echo "addnode=159.65.148.226" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.38.214") -eq 0 ]; then
	echo "addnode=165.227.38.214" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.167.79") -eq 0 ]; then
	echo "addnode=159.65.167.79" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.90.101") -eq 0 ]; then
	echo "addnode=159.65.90.101" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=128.199.218.139") -eq 0 ]; then
	echo "addnode=128.199.218.139" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=174.138.3.33") -eq 0 ]; then
	echo "addnode=174.138.3.33" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.203.167.75") -eq 0 ]; then
	echo "addnode=159.203.167.75" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=138.68.102.67") -eq 0 ]; then
	echo "addnode=138.68.102.67" >> /root/.3dcoin/3dcoin.conf
	fi	
    reboot'
}		

Update_Script_Single() {
	echo ""
    h=$(( RANDOM % 23 + 1 ));
	echo  -e "${BLUE} Start ${Update}                    ${STD}"
	rm -f /usr/local/bin/check.sh
	rm -f /usr/local/bin/update.sh
	rm -f /usr/local/bin/UpdateNode.sh
	rm -rf /usr/local/bin/Masternode
	echo ""
	cd ~
	echo  -e "${GREEN} Stop Cron                         ${STD}" 
	sudo /etc/init.d/cron stop
	echo ""
	echo  -e "${GREEN} Update crontab                    ${STD}"
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
	echo "Crontab updated successfully"
	echo ""
	echo  -e "${GREEN} Start Cron                        ${STD}"
	sudo /etc/init.d/cron start
	echo ""		
	echo  -e "${GREEN} Update Finished                   ${STD}"
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.72.203") -eq 0 ]; then
	echo "addnode=206.189.72.203" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.41.191") -eq 0 ]; then
	echo "addnode=206.189.41.191" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.197.115") -eq 0 ]; then
	echo "addnode=165.227.197.115" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=167.99.87.86") -eq 0 ]; then
	echo "addnode=167.99.87.86" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.201.222") -eq 0 ]; then
	echo "addnode=159.65.201.222" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.148.226") -eq 0 ]; then
	echo "addnode=159.65.148.226" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.38.214") -eq 0 ]; then
	echo "addnode=165.227.38.214" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.167.79") -eq 0 ]; then
	echo "addnode=159.65.167.79" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.90.101") -eq 0 ]; then
	echo "addnode=159.65.90.101" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=128.199.218.139") -eq 0 ]; then
	echo "addnode=128.199.218.139" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=174.138.3.33") -eq 0 ]; then
	echo "addnode=174.138.3.33" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.203.167.75") -eq 0 ]; then
	echo "addnode=159.203.167.75" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=138.68.102.67") -eq 0 ]; then
	echo "addnode=138.68.102.67" >> /root/.3dcoin/3dcoin.conf
	fi	
	echo ""
}	

Update_Script_Multi() {
    sshpass -p $rootpass ssh -p$sshport -o StrictHostKeyChecking=no root@$ipserver '
    h=$(( RANDOM % 23 + 1 ));
	rm -f /usr/local/bin/check.sh
	rm -f /usr/local/bin/update.sh
	rm -f /usr/local/bin/UpdateNode.sh
	rm -rf /usr/local/bin/Masternode
	cd ~
	echo ""
	echo "-----------------------------------------------------"
	echo  -e "${GREEN} Stop Cron                         ${STD}"
	echo "-----------------------------------------------------"
	sudo /etc/init.d/cron stop
	echo ""
	echo "-----------------------------------------------------"
	echo  -e "${GREEN} Update crontab                    ${STD}"
	echo "-----------------------------------------------------" 
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
	echo "Crontab updated successfully"
	sudo /etc/init.d/cron start
	echo "" 
	echo "-----------------------------------------------------"
	echo  -e "${GREEN} Update Finished                   ${STD}" 
	echo "-----------------------------------------------------"
	echo ""
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.72.203") -eq 0 ]; then
	echo "addnode=206.189.72.203" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.41.191") -eq 0 ]; then
	echo "addnode=206.189.41.191" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.197.115") -eq 0 ]; then
	echo "addnode=165.227.197.115" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=167.99.87.86") -eq 0 ]; then
	echo "addnode=167.99.87.86" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.201.222") -eq 0 ]; then
	echo "addnode=159.65.201.222" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.148.226") -eq 0 ]; then
	echo "addnode=159.65.148.226" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.38.214") -eq 0 ]; then
	echo "addnode=165.227.38.214" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.167.79") -eq 0 ]; then
	echo "addnode=159.65.167.79" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.90.101") -eq 0 ]; then
	echo "addnode=159.65.90.101" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=128.199.218.139") -eq 0 ]; then
	echo "addnode=128.199.218.139" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=174.138.3.33") -eq 0 ]; then
	echo "addnode=174.138.3.33" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.203.167.75") -eq 0 ]; then
	echo "addnode=159.203.167.75" >> /root/.3dcoin/3dcoin.conf
	fi
	if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=138.68.102.67") -eq 0 ]; then
	echo "addnode=138.68.102.67" >> /root/.3dcoin/3dcoin.conf
	fi'
}	

read_options(){
	local choice
	read -p "Enter choice [ 1 - 3] " choice
	case $choice in
	1) Update="Update Masternode & Auto-update"
	    echo ""
		echo  -e "${GREEN} Choose Type of Update                  ${STD}" 
        PS3='Please enter your choice: '
		options=("Update Single Masternode" "Update Multi Masternode")
		select opt in "${options[@]}"
		do
			case $opt in
				"Update Single Masternode")
					break
				;;
				"Update Multi Masternode")
					break
				;;
				*) echo invalid option;;
			esac
		done
		#### 3Dcoin Single Node installation
		if [ "$opt" == "Update Single Masternode" ]; then
			Update_Masternode_And_Script_Single
		else
		#### 3Dcoin Multi Node updatw
			echo ""
			echo  -e "${BLUE} Start ${Update}                    ${STD}"
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
				for ipserver in $vpsip
				do
					echo  -e "${GREEN} Connexion Vps ip $ipserver               ${STD}"
					echo ""
					Update_Masternode_And_Script_Multi
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
				for i in $data
				do
					vpsdata=$(echo $i | tr ":" "\n")
					declare -a array=($vpsdata)
					ipserver=${array[0]}
					rootpass=${array[1]}
					sshport=${array[2]}
					if [ -z "$rootpass" ] || [ -z "$sshport" ] || [ -z "$ipserver" ]
					then
						echo -e "Please enter a correct vps's data ${RED}( Exemple: 111.111.111.111:ERdX5h64dSer:22 222.222.222.222:Wz65D232Fty:165 ... )${STD}"
					else
						Update_Masternode_And_Script_Multi
					fi
				done
			else
			exit;
			fi
		fi
        exit 0;;
		
	2) Update="Update only Auto-update script"
	    echo "" 
		echo  -e "${GREEN} Choose Type of Update                  ${STD}" 
        PS3='Please enter your choice: '
		options=("Update Single Masternode" "Update Multi Masternode")
		select opt in "${options[@]}"
		do
			case $opt in
				"Update Single Masternode")
					break
				;;
				"Update Multi Masternode")
					break
				;;
				*) echo invalid option;;
			esac
		done
		#### 3Dcoin Single Node installation
		if [ "$opt" == "Update Single Masternode" ]; then
			Update_Script_Single
		else
			echo ""
			echo  -e "${BLUE} Start ${Update}                    ${STD}"
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
				for ipserver in $vpsip
				do
					echo  -e "${GREEN} Connexion Vps ip $ipserver               ${STD}"
					echo ""
					Update_Script_Multi
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
				for i in $data
				do
					vpsdata=$(echo $i | tr ":" "\n")
					declare -a array=($vpsdata)
					ipserver=${array[0]}
					rootpass=${array[1]}
					sshport=${array[2]}
					if [ -z "$rootpass" ] || [ -z "$sshport" ] || [ -z "$ipserver" ]
					then
						echo -e "Please enter a correct vps's data ${RED}( Exemple: 111.111.111.111:ERdX5h64dSer:22 222.222.222.222:Wz65D232Fty:165 ... )${STD}"
					else
						Update_Script_Multi
					fi
				done
			else
			exit;
			fi
		fi
        exit 0;;
		
	
		3) exit 0;;
		*) echo -e "${RED} Please choose the right choice... ${STD}" && sleep 2  
	    esac
}

while true
do
show_menus
read_options
done