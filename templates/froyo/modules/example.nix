{ inputs, config, ... }:
{
  modules.nixos.no-boot = {
    boot.loader.grub.enable = false;
    fileSystems."/".device = "/dev/no-device";
  };

  modules.nixos.statics = {
    system.stateVersion = "25.11";
    nixpkgs.hostPlatform = "x86_64-linux";
    passthru = { };
  };

  modules.nixos.my-laptop.imports = with config.modules.nixos; [
    statics
    no-boot
  ];

  outputs.nixosConfigurations.my-laptop = import "${inputs.nixpkgs}/nixos/lib/eval-config.nix" {
    modules = [ config.modules.nixos.my-laptop ];
  };
}
