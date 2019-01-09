# Masternode
3DCoin Masternode auto installer

**Warning: The installation must be run as root user!**

****************************************
Automatic install Single 3DCoin masternode
****************************************

```
curl -O https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/install.sh > install.sh
bash install.sh
```

* Choose Type of Node ( Exemple: Masternode Second choice (2) )
* Choose Type of Installation ( Exemple: Single Installation First choice (1) )
* Vps IP: enter your Vps IP Address.
* Rpc User: enter any string of numbers or letters, no special characters allowed
* Password: enter any string of numbers or letters, no special characters allowed
* Privatekey Masternode: this is the private key you generated from your wallet debug console.


# Update to last version:
```
curl -o- https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/AutoUpdate.sh | > AutoUpdate.sh
bash AutoUpdate.sh
```
