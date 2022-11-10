{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      hetzner-cloud-common = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/hetzner-cloud-common.nix
          ./ssh.nix
        ];
      };
    };
  };
}
