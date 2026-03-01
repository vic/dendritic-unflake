let
  sources = import ./npins;
  selfInputs = builtins.mapAttrs (name: value: mkInputs name value) sources;
  # from Nixlock: https://codeberg.org/FrdrCkII/nixlock/src/branch/main/default.nix
  mkInputs =
    name: sourceInfo:
    let
      flakePath = sourceInfo.outPath + "/flake.nix";
      isFlake = sources.${name}.flake or true;
    in
    if isFlake && builtins.pathExists flakePath then
      let
        flake = import (sourceInfo.outPath + "/flake.nix");
        inputs = builtins.mapAttrs (name: value: selfInputs.${name}) (flake.inputs or { });
        outputs = flake.outputs (inputs // { inherit self; });
        self =
          sourceInfo
          // outputs
          // {
            _type = "flake";
            inherit inputs sourceInfo;
          };
      in
      self
    else
      sourceInfo
      // {
        inherit sourceInfo;
      };
in
selfInputs
// {
  __functor =
    selfInputs: outputs:
    let
      self = outputs (selfInputs // { inherit self; });
    in
    self;
}
