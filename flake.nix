{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    signal-flags.url = "github:abidingabi/signal-flags";
  };

  outputs = { self, nixpkgs, signal-flags }: {
    nixosConfigurations = {
      hetzner-cloud-common = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/hetzner-cloud-common.nix

          ./services/ssh.nix
          ./services/web-server.nix
          ./services/cgit.nix

          signal-flags.nixosModules.x86_64-linux.signal-flags
        ];
      };
    };
  };
}
