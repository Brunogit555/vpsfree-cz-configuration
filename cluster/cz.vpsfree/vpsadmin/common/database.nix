{ pkgs, lib, config, confLib, confData, ... }:
let
  api1 = confLib.findConfig {
    cluster = config.cluster;
    name = "cz.vpsfree/vpsadmin/int.api1";
  };

  api2 = confLib.findConfig {
    cluster = config.cluster;
    name = "cz.vpsfree/vpsadmin/int.api2";
  };

  proxyPrg = confLib.findConfig {
    cluster = config.cluster;
    name = "cz.vpsfree/containers/prg/proxy";
  };
in {
  vpsadmin.database = {
    enable = true;

    defaultConfig = false;

    allowedIPv4Ranges =
      let
        management = map (net:
          "${net.address}/${toString net.prefix}"
        ) confData.vpsadmin.networks.management.ipv4;

        others = [
          "${api1.addresses.primary.address}/32"
          "${api2.addresses.primary.address}/32"
          "${proxyPrg.addresses.primary.address}/32"
          "172.16.8.5/32" # vpsadmin.int
          "37.205.8.141/32" # utils.vpsfree.cz
        ];
      in management ++ others;
  };
}
