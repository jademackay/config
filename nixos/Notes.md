

After modifying /etx/nix/configuration.nix:
```
sudo nixos-rebuild test # change to it but don't boot next time
sudo nixos-rebuild switch # switch & boot to it next time
sudo nixos-rebuild boot # don't switch but boot to it next time
```
Also useful 
```
sudo nixos-rebuild dry-build
```

No sound:
```
$ alsactl restore
```


Upgrading
```
nix-channel --update
sudo nix-channel --update
sudo nix-rebuild switch
sudo nix-rebuild switch --upgrade
```

To upgrade local stuff (shouldn't really use local?)
```
nix-env -u
```


Clean up boot:
```
nix-env -p /nix/var/nix/profiles/system --delete-generations +4
nixos-rebuild switch 
```

TODO
```configuration.nix
nix.autoOptimiseStore = true;
```

```
nix-collect-garbage -d
```
```
sudo nix-store --optimise
```

## Julia
