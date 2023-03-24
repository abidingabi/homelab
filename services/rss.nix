{ pkgs, ... }:

{
  services.miniflux = {
    enable = true;

    adminCredentialsFile = "/etc/secrets/miniflux-admin-credentials";

    config = {
      BASE_URL = "https://rss.priv.dogbuilt.net/";
      CREATE_ADMIN = "1";
      LISTEN_ADDR = "127.0.0.1:4001";
    };
  };
}
