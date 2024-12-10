{
  outputs =
    { ... }@inputs:
    {
      nixosConfigurations.experiment = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (
            { pkgs, ... }:
            {

              users.users.foo = {
                isNormalUser = true;
                initialPassword = "foo";
              };

              environment.systemPackages = with pkgs; [ hello ];
              system.stateVersion = "23.11";
            }
          )
        ];
      };
    };

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";
    nixpkgs.follows = "nixpkgs-unstable";
  };
}
