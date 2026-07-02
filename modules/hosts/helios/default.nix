{ self, inputs, ... }: {
  flake.nixosConfigurations.helios = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.helios
    ];
  };
}
