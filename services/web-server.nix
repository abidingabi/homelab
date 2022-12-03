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

      git.dogbuilt.net {
        @cgitresources path robots.txt /cgit*

        handle @cgitresources {
          root * ${pkgs.cgit-pink}/cgit/
          file_server
        }

        handle {
          reverse_proxy unix//run/fcgiwrap.sock {
            transport fastcgi {
              env SCRIPT_FILENAME ${pkgs.cgit-pink}/cgit/cgit.cgi
              env PATH_INFO {uri}
              env QUERY_STRING {args}
              env HTTP_HOST {host}
            }
          }
        }
      }
    '';
  };
}
