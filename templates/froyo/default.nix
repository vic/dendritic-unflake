let
  inputs = import ./npins;
in
import inputs.froyo { inherit inputs; } {
  inherit inputs;
  imports = [ (import inputs.import-tree ./modules) ];
}
