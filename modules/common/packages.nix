{ pkgs, ... }: {

  flake.nixosModules.commonPackages = { config, lib, pkgs, modulesPath, ... }: 
  {
    environment.systemPackages = with pkgs; [
      git
      wget
      curl
      vim
      neovim
    ];
  };

}
