{

 description = "my first flake";

 inputs = {
   nixpkgs.url = "nixpkgs/nixos-24.05";
   home-manager.url = "github:nix-community/home-manager/release-24.05";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
 };

 outputs = {self, nixpkgs, home-manager,  ...}:
   let 
     # variables that are used in the flake's modules
     lib = nixpkgs.lib;
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
     username = "hernies";
     gitArgs = {
       name = "Hernies";
       mail = "hernancalvoaguiar.2@gmail.com";
     };
     # -- future variables or var groups here -- #
   
   in {
     nixosConfigurations = {
       #nixos is my hostname
       nixos = lib.nixosSystem {
         inherit system;
         modules = [ ./configuration.nix ];
       };
       specialArgs = {
         inherit username;
         # -- future inheritance of variables or var groups here -- #       
       };
     };
 packages = {
 nbfc = pkgs.stdenv.mkDerivation{
  name = "nbfc-linux";
          version = "0.1.15";

          src = nixpkgs.lib.cleanSource ./.;

          nativeBuildInputs = with pkgs; [
            autoreconfHook
          ];
          configureFlags = [
            "--prefix=${placeholder "out"}"
            "--sysconfdir=${placeholder "out"}/etc"
            "--bindir=${placeholder "out"}/bin"
          ];
        };
};
   homeConfigurations = {
       hernies = home-manager.lib.homeManagerConfiguration {
       inherit pkgs;
       modules = [ ./home.nix ];
       extraSpecialArgs = {
         inherit username;
         inherit gitArgs;
         # -- future inheritance of variables or var groups here -- #
       };
     };
   };
 };

}
