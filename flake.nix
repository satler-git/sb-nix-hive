{
  outputs =
    {
      std,
      hive,
      self,
      ...
    }@inputs:
    hive.growOn
      {
        inherit inputs;
        cellsFrom = ./cells;
        cellBlocks =
          with hive.blockTypes;
          with std.blockTypes;
          [
            (functions "bee")
            (functions "system")
            nixosConfigurations
          ];
      }
      {
        nixosConfigurations = hive.collect self "nixosConfigurations";
      };

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.follows = "nixpkgs-stable";

    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hive = {
      url = "github:divnix/hive";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
