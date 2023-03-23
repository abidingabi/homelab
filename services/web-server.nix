{ pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;

    extraConfig = ''
      signalflags.dogbuilt.net {
        encode zstd gzip
        reverse_proxy localhost:3000
      }

      rss.dogbuilt.net {
        encode zstd gzip
        reverse_proxy localhost:3001
      }

      static.dogbuilt.net {
        encode zstd gzip
        root * /srv/static
        file_server browse
      }
    '';
  };
}
