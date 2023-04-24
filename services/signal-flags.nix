{ pkgs, ... }:

let
  port = 3000;
  hostname = "signalflags.dogbuilt.net";
in {
  dogbuilt.services.signal-flags = {
    enable = true;
    inherit port;
    url = "https://${hostname}/";
  };

  services.caddy.extraConfig = ''
    ${hostname} {
      encode zstd gzip
      reverse_proxy localhost:${toString port}
    }
  '';
}
