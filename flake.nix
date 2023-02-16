{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.impermanence.url = "github:nix-community/impermanence";
  inputs.rust-overlay.url = "github:oxalica/rust-overlay";
  inputs.nixos-cn.url = "github:nixos-cn/flakes";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nur.url = "github:nix-community/NUR";
  inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nickcao = {
    url = "github:NickCao/flakes";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.anillc = {
    url = "github:Anillc/flakes";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{
    self, nixpkgs, impermanence, sops-nix, home-manager, nur,
    nickcao, nixos-cn, anillc, flake-utils, rust-overlay
  }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
  in {
    devShell = pkgs.mkShell {
      nativeBuildInputs = [ pkgs.sops ];
    };
    packages = pkgs;
  }) // {
    nixosConfigurations.an = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        { nixpkgs.overlays = [
          (self: super: {
            inherit inputs;
          } // anillc.packages.${system})
          nur.overlay nixos-cn.overlay
          rust-overlay.overlays.default
        ]; }
        sops-nix.nixosModules.sops
        impermanence.nixosModules.impermanence
        home-manager.nixosModules.home-manager
        ./modules
      ];
    };
  };
}
