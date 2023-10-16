{
  description = "NixOS of zhews";
  inputs = {
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { home-manager, nixpkgs, ... }:
    let
      hostname = "nixos";
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
      username = "zhews";
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home ];
      };
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./system ];
      };
    };
}
