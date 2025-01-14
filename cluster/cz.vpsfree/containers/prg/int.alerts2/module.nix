{ config, ... }:
{
  cluster."cz.vpsfree/containers/prg/int.alerts2" = rec {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "os-staging" ];
    container.id = 19502;
    host = { name = "alerts2"; location = "int.prg"; domain = "vpsfree.cz"; };
    addresses.primary = { address = "172.16.4.19"; prefix = 32; };
    services = {
      alertmanager = {};
      node-exporter = {};
    };
    tags = [ "alerter" ];
  };
}
