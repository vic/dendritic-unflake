{ pins, config, ... }:
{
  flake.modules.nixos.no-boot = {
    boot.loader.grub.enable = false;
    fileSystems."/".device = "/dev/no-device";
  };

  flake.modules.nixos.statics = {
    system.stateVersion = "25.11";
    nixpkgs.hostPlatform = "x86_64-linux";
    passthru = { };
  };

  flake.modules.nixos.my-laptop.imports = with config.flake.modules.nixos; [
    statics
    no-boot
  ];

  flake.nixosConfigurations.my-laptop = import "${pins.nixpkgs}/nixos/lib/eval-config.nix" {
    modules = [ config.flake.modules.nixos.my-laptop ];
  };
}
