 { self, inputs, ... }: {
  
  # This tells flake-parts to export this setup globally on the `self` variable!
  flake.homeManagerModules.bunny = { config, pkgs, ... }: {
    
    home.stateVersion = "26.05"; 
    xdg.configFile."niri/config.kdl".source = ./niri.kdl;
    
  };
}
