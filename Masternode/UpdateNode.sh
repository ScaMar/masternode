#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
LOGFILE='/usr/local/bin/Masternode/update.log'
dt=`date '+%d/%m/%Y %H:%M:%S'`
latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
localrelease=$(3dcoin-cli -version | awk -F' ' '{print $NF}' | cut -d "-" -f1)
if [ -z "$latestrelease" ] || [ "$latestrelease" == "$localrelease" ]; then 
echo >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
echo "[$dt]==> Info: There is no New Update latest release is $latestrelease" >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
exit;
else
echo >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
echo "[$dt]==> Info: Starting Update 3DCoin core to $latestrelease" >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
cd ~
localfile=${localrelease//[Vv]/3dcoin-}
echo "[$dt]==> Info: Remove file $localfile" >> $LOGFILE
rm -rf $localfile
link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.tar.gz"
echo "[$dt]==> Info: Download Last Update $link" >> $LOGFILE
wget $link  || { echo "[$dt]==> Error: When Download $link" >> $LOGFILE && exit;  }
echo "[$dt]==> Info: Extract $latestrelease.tar.gz" >> $LOGFILE
tar -xvzf $latestrelease.tar.gz || { echo "[$dt]==> Error: When Extracting $latestrelease.tar.gz" >> $LOGFILE && exit;  }
file=${latestrelease//[Vv]/3dcoin-}
cd $file  || { echo "[$dt]==> Error: File $file not found" >> $LOGFILE && exit;  }
echo "[$dt]==> Info: Start Compiling 3Dcoin core $latestrelease" >> $LOGFILE
./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make || { echo "[$dt]==> Error: When Compiling 3Dcoin core" >> $LOGFILE && exit;  }
echo "[$dt]==> Info: Stop 3DCoin core $localrelease" >> $LOGFILE
3dcoin-cli stop
sleep 10
echo "[$dt]==> Info: Make install            " >> $LOGFILE
make install-strip || { echo "[$dt]==> Error: When make install" >> $LOGFILE && exit && 3dcoind;  }
cd ~
echo "[$dt]==> Info: Remove $latestrelease.tar.gz" >> $LOGFILE
rm $latestrelease.tar.gz
echo "[$dt]==> Info: Remove $file" >> $LOGFILE
rm -rf $file
echo "[$dt]==> Info: Rebooting " >> $LOGFILE 
echo "[$dt]    ==============================================================" >> $LOGFILE
reboot
fi
