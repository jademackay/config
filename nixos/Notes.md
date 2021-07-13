

After modifying /etx/nix/configuration.nix:
```
sudo nixos-rebuid test # change to it but don't boot next time
sudo nixos-rebuid switch # switch & boot to it next time
sudo nixos-rebuid boot # don't switch but boot to it next time
```
Also useful 
```
sudo nixos-rebuild dry-build
```

No sound:
```
$ alsa restore
```


Upgrading
```
nix-channel --update
sudo nix-channel --update
sudo nix-rebuild switch.
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
nix-collect-garbage
```


## Julia
