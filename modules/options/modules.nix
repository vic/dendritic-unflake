{ lib, ... }:
{
  options.flake.modules = lib.mkOption {
    description = "<class>.<aspect> modules. akin to flake-parts' flake.modules";
    default = { };
    type = lib.types.lazyAttrsOf (lib.types.lazyAttrsOf lib.types.deferredModule);
  };
}
