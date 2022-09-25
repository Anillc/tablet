{
  vscode-utils,
  vscode-extensions,
  vscode-with-extensions,
  ...
}: vscode-with-extensions.override {
  vscodeExtensions = with vscode-extensions; [
    llvm-vs-code-extensions.vscode-clangd
    WakaTime.vscode-wakatime
    rust-lang.rust-analyzer
    vadimcn.vscode-lldb
    eamodio.gitlens
    haskell.haskell
    vscodevim.vim
    bbenoist.nix
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-direnv";
      publisher = "Rubymaniac";
      version = "0.0.2";
      sha256 = "sha256-TVvjKdKXeExpnyUh+fDPl+eSdlQzh7lt8xSfw1YgtL4=";
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
      sha256 = "sha256-IDCvqRKEqdP9QUejkE/Xe4+I0ma/We634bfSX8HZ2bI=";
    }
  ];
}