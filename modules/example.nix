{ lib, self, ... }:
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

  flake.modules.nixos.my-laptop.imports = with self.modules.nixos; [
    statics
    no-boot
  ];

  flake.nixosConfigurations.my-laptop = lib.nixosSystem {
    modules = [ self.modules.nixos.my-laptop ];
  };
}
