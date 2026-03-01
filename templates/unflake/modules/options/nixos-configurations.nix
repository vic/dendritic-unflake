{ lib, ... }:
{
  options.nixosConfigurations = lib.mkOption {
    description = "NixOS configurations";
    default = { };
    type = lib.types.lazyAttrsOf lib.types.raw;
  };
}
