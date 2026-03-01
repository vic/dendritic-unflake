let
  pins = import ./npins;
  inherit (pins) nixpkgs falake;
  pkgs = import nixpkgs { };
in
(import falake).mkFalake pkgs.lib { inherit pins; } {
  inherit nixpkgs;
  imports = [
    (import pins.import-tree ./modules)
  ];
}