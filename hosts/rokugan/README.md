# Rokugan

Futuro VPS/server.

Objetivo:
- Infra personal estable
- Acceso SSH seguro
- Backups
- Servicios pequeños propios
- Deploys reproducibles con NixOS

Pendiente decidir:
- Proveedor VPS
- Dominio/subdominio
- Firewall
- SSH keys
- Backups/restic
- Servicios a alojar
- Monitoring básico

Cuando toque:
1. Crear servidor con imagen NixOS o instalar NixOS manualmente
2. Añadir hardware/config mínima en hosts/rokugan/
3. Añadir nixosConfigurations.rokugan al flake.nix
4. Aplicar remotamente con algo tipo:
   nixos-rebuild switch --flake .#rokugan --target-host root@IP
