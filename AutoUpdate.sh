
#####################################################################################
#                           Update 3DCoin Core V 0.14 	                            #
#####################################################################################
EDITOR=vim
RED='\033[0;41;30m'
STD='\033[0;0;39m'
GREEN='\e[1;97;42m'
BLUE='\e[1;97;44m'

show_menus() {
	clear
	echo ""	
	echo  -e "${BLUE} U P D A T E  3 D C O I N  M A S T E R N O D E ${STD}"
	echo ""
	echo "1. Update Single Masternode"
	echo "2. Update Multi Masternodes"
	echo "3. Exit"
	echo ""
    echo  -e "\e[1;97;41m Note!!: Update 3DCoin Core V 0.14 & Update for Auto-update   ${STD}"
	echo ""
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 3] " choice
	case $choice in
		1) Update="Update 3DCoin Masternode"
        echo ""
        echo  -e "${BLUE} Start ${Update}                    ${STD}"
        dir=$( echo $(find / -type d -name '3dcoin') | cut -d' ' -f1)
        cd $dir
        rm -f /usr/local/bin/check.sh
        rm -f /usr/local/bin/update.sh
        rm -f /usr/local/bin/UpdateNode.sh
        echo ""
        echo  -e "${GREEN} Git checkout master               ${STD}"
        git checkout master
        echo ""
        echo  -e "${GREEN} Make clean                        ${STD}"
        make clean
        echo ""
        echo  -e "${GREEN} Git pull                          ${STD}"
        git pull
        echo ""
        echo  -e "${GREEN} Stop Cron                         ${STD}" 
        sudo /etc/init.d/cron stop
        echo ""
        echo  -e "${GREEN} Stop 3Dcoin core                  ${STD}"
        3dcoin-cli stop
		sleep 10
        echo ""		
        echo  -e "${GREEN} Make install                      ${STD}"
        make install-strip || { ./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;  }
		sleep 10
        echo ""
        echo  -e "${GREEN} Update crontab                    ${STD}"
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
cd $dir
git checkout master
make clean
git pull
3dcoin-cli stop
sleep 10
make install-strip || { ./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;  }
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
        echo "Crontab updated successfully"
        echo ""
        echo  -e "${GREEN} Start Cron                        ${STD}"
        sudo /etc/init.d/cron start
        echo ""		
	    echo  -e "${GREEN} Update Finished,rebooting server  ${STD}" 
        reboot
		echo ""
        exit 0;;
		
        2) Update="Update 3DCoin Masternode"
        echo ""
        echo  -e "${BLUE} Start ${Update}                    ${STD}"
        echo ""
		
        echo  -e "${GREEN} Enter Vps ip's                    ${STD}"
		echo ""
		echo  -e "Please enter your vps ip's: ${RED}(Exemple: 111.111.111.111 222.222.222.222 ) ${STD}"
		unset ip
        while [ -z ${ip} ]; do
        read -p "IP HERE: " ip
        done
		apt-get update
		yes | apt-get install sshpass
        for i in $ip
        do
        echo  -e "${GREEN} Connexion Vps ip $i               ${STD}"
        echo ""
		unset rootpass
        while [ -z ${rootpass} ]; do
        read -s -p "Please Enter Password Root $i: " rootpass
        done

        sshpass -p $rootpass ssh -o StrictHostKeyChecking=no root@$i '
        dir=$( echo $(find / -type d -name "3dcoin") | cut -d" " -f1)
        cd $dir
        rm -f /usr/local/bin/check.sh
        rm -f /usr/local/bin/update.sh
        rm -f /usr/local/bin/UpdateNode.sh
        echo ""
        echo "-----------------------------------------------------"
        echo  -e "${GREEN} Git checkout master               ${STD}"
        echo "-----------------------------------------------------"
        git checkout master
        echo ""
        echo "-----------------------------------------------------"
        echo  -e "${GREEN} Make clean                        ${STD}"
        echo "-----------------------------------------------------"
        make clean
        echo ""
        echo "-----------------------------------------------------"
        echo  -e "${GREEN} Git pull                          ${STD}"
        echo "-----------------------------------------------------"
        git pull
        echo ""
        echo "-----------------------------------------------------"
        echo  -e "${GREEN} Stop Cron                         ${STD}"
        echo "-----------------------------------------------------"
        sudo /etc/init.d/cron stop
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
        make install-strip || { ./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;  }
		sleep 10
        echo ""
        echo "-----------------------------------------------------"
        echo  -e "${GREEN} Update crontab                    ${STD}"
        echo "-----------------------------------------------------" 
		echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestrelease=\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"'"\\$"\"tag_name"\\$"\":'"' | sed -E '"'s/.*"\\$"\"([^"\\$"\"]+)"\\$"\".*/\1/'"')
localrelease=\$(3dcoin-cli -version | awk -F'"' '"' '"'{print "\\$"\$NF}'"' | cut -d \"-\" -f1)
if [ -z \"\$latestrelease\" ] || [ \"\$latestrelease\" == \"\$localrelease\" ]; then
exit;
else
cd $dir
git checkout master
make clean
git pull
3dcoin-cli stop
sleep 10
make install-strip || { ./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;  }
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
        echo "Crontab updated successfully"
        echo ""
        echo "-----------------------------------------------------"
	    echo  -e "${GREEN} Update Finished,rebooting server  ${STD}" 
        echo "-----------------------------------------------------"
        reboot
		echo ""'
        done
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