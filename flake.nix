{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
  # https://github.com/vuejs/language-tools/issues/5941
  inputs.nixpkgs-volar.url = "github:NixOS/nixpkgs/f4b140d5b253f5e2a1ff4e5506edbf8267724bde";
  inputs.impermanence.url = "github:nix-community/impermanence";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.lanzaboote = {
    url = "github:nix-community/lanzaboote";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{
    self, nixpkgs, impermanence, sops-nix,
    flake-utils, lanzaboote, ...
  }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
  in {
    devShell = pkgs.mkShell {
      nativeBuildInputs = [ pkgs.sops ];
    };
    packages = pkgs;
  }) // {
    nixosConfigurations.duet = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        sops-nix.nixosModules.sops
        impermanence.nixosModules.impermanence
        lanzaboote.nixosModules.lanzaboote
        ./modules
      ];
    };
  };
}
