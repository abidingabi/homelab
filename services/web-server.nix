{ pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;

    extraConfig = ''
      signalflags.dogbuilt.net {
        reverse_proxy localhost:3000
      }

      static.dogbuilt.net {
        root * /srv/static
        file_server browse
      }
    '';
  };
}
