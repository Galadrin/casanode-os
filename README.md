# Prerequisites install

## Docker

Based on Debian 12

```
sudo apt-get install docker.io
sudo gpasswd -a ${USER} docker
```

Restart the user session to take the docker group into account

# Install from scratch

```
git clone git@github.com:Galadrin/casanode-os.git
cd casanode-os
```

# Start build

From casanode-os directory

```
make run
cooker cook ../casanode.json raspberry-pi-4-casanode
```
