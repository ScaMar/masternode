# Masternode-3dcoin

****************************************
### Bash Updater for masternode on Ubuntu 16.04 LTS x64 <This script must be run as root user!>
****************************************
 > **Version: 1.0.1:**
* Add Auto-update for update/install scripts.
* Updatetime is random for each vps.
* Clear debug log every 2 days.
* Add log file to UpdateNode shell.
* Using this shell script for a single update or Multi-vps update.

 > **This shell script has 4 cronjobs:**

1. Scripts auto-update: [Check-scripts.sh](https://github.com/BlockchainTechLLC/masternode/blob/master/Masternode/Check-scripts.sh)
2. Make sure the daemon is never get stuck: [daemon_check.sh](https://github.com/BlockchainTechLLC/masternode/blob/master/Masternode/daemon_check.sh)
3. Clear the log file: [clearlog.sh](https://github.com/BlockchainTechLLC/masternode/blob/master/Masternode/clearlog.sh)
4. Auto-update for 3DCoin Core: [UpdateNode.sh](https://github.com/BlockchainTechLLC/masternode/blob/master/Masternode/UpdateNode.sh)


> **How to use:**

Login to your vps as root, download and run the Update.sh file using this command:

```
curl -O https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Update.sh > Update.sh
bash Update.sh
```

> **Available options:**

1. **Update Masternode & Auto-update script**
2. **Update only the Auto-update script**
3. **Exit**

**1. Update Masternode & Auto-update script:**
-----------------------------------------------------------------
This option will update 3dcoin core & the update script, PS. Available for both single and multi-vps update: 

  **1.1-Update a Single Masternode:**
  
    This option update only the vps that runs the shell script.
    
  **1.2- Update Multi-vps Masternode**
  
    This option updates all the vps that you will add using these two options here:
    
      1.2.1. Use Same SSH Port and Password for all vps's:
      
             Enter your vps ip's: (Exemple: 111.111.111.111-222.222.222.222-... )
             
             SSH port: (Exemple: 22 )
             
             password: (Exemple: Des53G2v3P )
             
      1.2.2. Use a different SSH Port and Password for each vps:
      
             Eter your vps data: 'Host:Password:SSHPort' ( Exemple: 111.111.111.111:ERdX5h64dSer:22-222.222.222.222:Wz65D232Fty:165-... )
             
**2. Update the Auto-update script only:**
-------------------------------------------------------------
This option wil update only the shell scripts in your vps, PS. Available for both single and multi-vps update: 

             
**3. Exit:**
-------------------------------------------------------------   
This option to close Shell script. 



****************************************
### Bash Checker for Masternodes on Ubuntu 16.04 LTS x64 <This script must be run as root user!>
***************************************

```
curl -O https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/check-masternode.sh > check-masternode.sh
bash check-masternode.sh
```
