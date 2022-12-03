{ config, lib, pkgs, ... }:

{
  services.fcgiwrap = {
    enable = true;
  };

  environment.etc.cgitrc.source = ./cgitrc;
}
