# My nixos config


## Beginners
* Begin by creating a bootable usb drive with nixos 25.05 (stable)
* after installation, either go into configuration.nix and add git:
'sudo nano /etc/nixos/configuration.nix'
then google about your GPU and add the lines needed for your specific card 
**NOTE: GPU drivers are case by case especially with NVIDIA laptop gpus, do this now or sufffer the consequences later**
rebuild with: 'sudo nixos-rebuild switch'

enter a temporary shell

nix-shell -p git

and clone this repo in your home directory: git clone https://github.com/Hernies/nixos.git

then rename the folder to .dotfiles 'mv nixos .dotfiles'

then exit the temporary shell with Ctrl+D

## After cloning
Copy your systems hardware-configuration.nix
'cp /etc/nixos/hardware-configuration'

Then rebuild nix and build home-manager:
'sudo nixos-rebuild switch --flake .'
'home-manager switch --flake .'

and now you have successfuly cloned and built my config in your own system
