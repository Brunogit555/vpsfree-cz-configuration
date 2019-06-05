{ config, pkgs, lib, ... }:
let
  images = import ../images.nix { inherit lib pkgs; };
in
{
  imports = [
    ../modules/netboot.nix
    ../modules/web.nix
  ];

  netboot = {
    host = "boot.vpsadminos.org";
    acmeSSL = true;
    inherit (images) nixosItems vpsadminosItems mappings;
  };

  web = {
    acmeSSL = true;
    domain = "vpsadminos.org";
    isoImages = [ images.vpsadminosISO ];
  };
}