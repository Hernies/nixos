{
  description = "Hernies NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        kyuden = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/kyuden/configuration.nix
          ];
        };
      };
    };
}
