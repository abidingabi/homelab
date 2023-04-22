{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    signal-flags.url = "github:abidingabi/signal-flags";
  };

  outputs = { self, nixpkgs, signal-flags }: {
    nixosConfigurations = {
      lily = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/lily.nix

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
