{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    signal-flags.url = "github:abidingabi/signal-flags";
  };

  outputs = { self, nixpkgs, signal-flags }: {
    nixosConfigurations = {
      hetzner-cloud-common = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/hetzner-cloud-common.nix

          ./services/ssh.nix
          ./services/headscale.nix
          ./services/web-server.nix

          ./services/rss.nix

          signal-flags.nixosModules.default
          ./services/signal-flags.nix
        ];
      };
    };
  };
}
