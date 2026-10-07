{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.vscode-extensions; [
        llvm-vs-code-extensions.vscode-clangd
        vue.volar
        justusadam.language-haskell
        myriad-dreamin.tinymist
        rust-lang.rust-analyzer
        mesonbuild.mesonbuild
        vadimcn.vscode-lldb
        banacorn.agda-mode
        jnoortheen.nix-ide
        scala-lang.scala
        scalameta.metals
        adpyke.codesnap
        eamodio.gitlens
        haskell.haskell
        tomoki1207.pdf
        vscodevim.vim
        bbenoist.nix
        mkhl.direnv
        golang.go
      ];
    })
  ];

  environment.persistence."/persist".users.anillc.directories = [
    ".config/Code"
    ".vscode"
  ];
}
