# Hiruma

Portátil. Pendiente de migrar.

Estado actual: NixOS Warbler.

Cuando toque:
1. Clonar este repo en ~/.dotfiles
2. Generar hardware config en el portátil:
   sudo nixos-generate-config --show-hardware-config > hosts/hiruma/hardware-configuration.nix
3. Crear hosts/hiruma/configuration.nix
4. Añadir nixosConfigurations.hiruma al flake.nix
5. Aplicar con:
   sudo nixos-rebuild switch --flake ~/.dotfiles#hiruma
