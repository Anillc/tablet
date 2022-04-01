{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
  inputs.impermanence.url = "github:nix-community/impermanence";
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nur = {
    url = "github:nix-community/NUR";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nixos-cn = {
    url = "github:nixos-cn/flakes";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, impermanence, home-manager, nur, nixos-cn, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
  in {
  }) // {
    nixosConfigurations.an = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        { nixpkgs.overlays = [(self: super: {
          inherit inputs;
        })]; }
        impermanence.nixosModules.impermanence
        home-manager.nixosModules.home-manager
        { nixpkgs.overlays = [ nur.overlay nixos-cn.overlay ];}
        ./modules/configuration.nix
      ];
    };
  };
}
