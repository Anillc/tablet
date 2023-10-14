{
  vscode-utils,
  vscode-extensions,
  vscode-with-extensions,
  ...
}: vscode-with-extensions.override {
  vscodeExtensions = with vscode-extensions; [
    llvm-vs-code-extensions.vscode-clangd
    justusadam.language-haskell
    WakaTime.vscode-wakatime
    rust-lang.rust-analyzer
    vadimcn.vscode-lldb
    jnoortheen.nix-ide
    adpyke.codesnap
    eamodio.gitlens
    haskell.haskell
    github.copilot
    vscodevim.vim
    bbenoist.nix
    golang.go
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "direnv";
      publisher = "mkhl";
      version = "0.14.0";
      sha256 = "sha256-T+bt6ku+zkqzP1gXNLcpjtFAevDRiSKnZaE7sM4pUOs=";
    }
    {
      name = "discord-vscode";
      publisher = "icrawl";
      version = "5.8.0";
      sha256 = "sha256-IU/looiu6tluAp8u6MeSNCd7B8SSMZ6CEZ64mMsTNmU=";
    }
    {
      name = "volar";
      publisher = "Vue";
      version = "0.40.13";
      sha256 = "sha256-M14Zgb+8O6BrzdFDVJf9xuydYq1Me2tCdPn3fSATR0E=";
    }
    {
      name = "language-gas-x86";
      publisher = "basdp";
      version = "0.0.2";
      sha256 = "sha256-PbXhOsoR0/5wXuFrzwCcauM1uGgfQoSRTj0gPVVZ4Kg=";
    }
    {
      name = "agda-mode";
      publisher = "banacorn";
      version = "0.3.12";
      sha256 = "sha256-RazX+d48xLAUB6YkKVg/E+KHasOV/F395I/q/7DMu6M=";
    }
    {
      name = "mesonbuild";
      publisher = "mesonbuild";
      version = "1.12.1";
      sha256 = "sha256-LPJmqR60Hupjs/ogClHF7WdVgV/ZCakILdrYdRPCaDo=";
    }
  ];
}