 { self, inputs, ... }: {
  flake.homeManagerModules.bunny = { config, pkgs, ... }: {

    home.stateVersion = "26.05"; #don't touch this even if updating
    xdg.configFile."niri/config.kdl".source = ./niri.kdl;

    home.packages = with pkgs; [
      kitty
      fuzzel
    ];

  };
}
