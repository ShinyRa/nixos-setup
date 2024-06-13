{
  description = "Nixos work environment";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # NixOS configuration entrypoint
  # Available through 'nixos-rebuild --flake .#tijs'
  outputs = { self, nixpkgs, home-manager, ... } @ inputs: let
    system = "x86_64-linux";
    username = "tijs";
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      "${username}" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [./nixos/configuration.nix];
       };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#tijs@nixos'
    homeConfigurations = {
      "${username}" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [./home-manager/home.nix];
      };
    };
  };
}
