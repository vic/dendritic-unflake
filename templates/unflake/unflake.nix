let
  deps = rec {
    unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "677fbe97984e7af3175b6c121f3c39ee5c8d62c9";
      narHash = "sha256-g2a4MhRKu4ymR4xwo+I+auTknXt/+j37Lnf0Mvfl1rE=";
    };
    unflake_github_vic_import-tree = builtins.fetchTree {
      type = "github";
      owner = "vic";
      repo = "import-tree";
      rev = "3c23749d8013ec6daa1d7255057590e9ca726646";
      narHash = "sha256-ZvYKbFib3AEwiNMLsejb/CWs/OL/srFQ8AogkebEPF0=";
    };
  };
  universe = rec {
    unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable = ((import "${deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable.outPath}/flake.nix").outputs {
      self = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    }) // deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable // {
      _flake = true;
      outPath = "${deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable.outPath}";
      sourceInfo = deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    };
    unflake_github_vic_import-tree = ((import "${deps.unflake_github_vic_import-tree.outPath}/flake.nix").outputs {
      self = unflake_github_vic_import-tree;
    }) // deps.unflake_github_vic_import-tree // {
      _flake = true;
      outPath = "${deps.unflake_github_vic_import-tree.outPath}";
      sourceInfo = deps.unflake_github_vic_import-tree;
    };
  };
  inputs = {
    import-tree = universe.unflake_github_vic_import-tree;
    nixpkgs = universe.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    self = throw "to use inputs.self, write `import ./unflake.nix (inputs: ...)`";
    withInputs = outputs: let self = outputs (inputs // { inherit self; }); in self;
    __functor = self: self.withInputs;
  };
in inputs