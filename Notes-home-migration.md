# Home migration

## Migrate data

As root
```
fdisk /dev/sdc
mkfs.ext4 /dev/sdc1
mount 
```
Weirdly the above was changed to sdb later by the system




As sudo
```
sudo mkdir /mnt/home-ssd
sudo mount /dev/sdc1 /mnt/home-ssd
sudo rsync -axHAWXS --numeric-ids --info=progress2 /home/ /mnt/home-ssd
```


## Update Nix Configuration



https://discourse.nixos.org/t/how-to-add-second-hard-drive-hdd/6132

```
sudo nixos-generate-config
```



TODO: before doing anything change my configuration.nix to not have 
```
# /etc/nixos/configuration.nix
#home = "/home/jade";
```
then
```
sudo nixos-rebuild switch
sudo reboot
```

