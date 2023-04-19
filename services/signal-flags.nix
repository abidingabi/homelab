{ pkgs, ... }:

let port = 3000;
in {
  dogbuilt.services.signal-flags = {
    enable = true;
    inherit port;
  };

  services.caddy.extraConfig = ''
    signalflags.dogbuilt.net {
      encode zstd gzip
      reverse_proxy localhost:${toString port}
    }
  '';
}
