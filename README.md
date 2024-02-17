How to build

```sh
nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=./sd-image.nix -I 'nixpkgs=https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-23.11.zip' 
```
