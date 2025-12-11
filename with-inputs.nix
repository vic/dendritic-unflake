let
  sources = {
    # impure: from local nixpkgs registry, replace with fixed fetchGit if desired.
    nixpkgs.outPath = <nixpkgs>;

    import-tree = builtins.fetchGit {
      url = "https://github.com/vic/import-tree.git";
      ref = "main";
      shallow = true;
      narHash = "sha256-ZvYKbFib3AEwiNMLsejb/CWs/OL/srFQ8AogkebEPF0=";
      rev = "3c23749d8013ec6daa1d7255057590e9ca726646";
    };
  };

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
