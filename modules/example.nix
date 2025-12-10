{ lib, self, ... }:
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

  modules.nixos.my-laptop.imports = with self.modules.nixos; [
    statics
    no-boot
  ];

  nixosConfigurations.my-laptop = lib.nixosSystem {
    modules = [ self.modules.nixos.my-laptop ];
  };
}
