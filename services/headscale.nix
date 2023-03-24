{ config, pkgs, ... }: {
  networking.firewall = {
    allowedUDPPorts = [ config.services.tailscale.port ];
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
  };

  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 4000;
    settings = {
      server_url = "https://hs.dogbuilt.net";
      logtail.enabled = false;
      ip_prefixes = [ "fd7a:115c:a1e0::/48" "100.64.0.0/10" ];

      dns_config = {
        base_domain = "dogbuilt.net";
        extra_records = [{
          name = "rss.priv.dogbuilt.net";
          type = "A";
          value = "100.64.0.1";
        }];
      };
    };
  };
  environment.systemPackages = [ config.services.headscale.package ];

  # Enable acting as an exit node
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  services.tailscale.enable = true;
}
