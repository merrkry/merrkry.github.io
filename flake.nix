{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

  outputs =
    { ... }@inputs:
    let
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = inputs.nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        {
          default = with pkgs; mkShell { nativeBuildInputs = [ hugo ]; };
        }
      );
    };
}
