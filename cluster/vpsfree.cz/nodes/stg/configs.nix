{ config, ... }:
{
  cluster."vpsfree.cz".nodes.vpsadminos.stg = {
    node1 = {
      nodeId = 400;

      networking = {
        netboot = {
          enable = true;
          macs = [
            "0c:c4:7a:30:76:18"
            "0c:c4:7a:30:76:19"
            "0c:c4:7a:30:76:1a"
            "0c:c4:7a:30:76:1b"
          ];
        };

        interfaces = {
          names = {
            teng0 = "0c:c4:7a:88:69:d8";
            teng1 = "0c:c4:7a:88:69:d9";
          };
          addresses = {
            teng0 = { v4 = [ "172.16.251.2/30" ]; v6 = [ "2a03:3b40:42:2:01::2/80" ]; };
            teng1 = { v4 = [ "172.16.250.2/30" ]; v6 = [ "2a03:3b40:42:3:01::2/80" ]; };
          };
        };

        bird = {
          as = 4200001001;
          routerId = "172.16.251.2";
          bgpNeighbours = {
            v4 = [
              { address = "172.16.251.1"; as = 4200001901; }
              { address = "172.16.250.1"; as = 4200001902; }
            ];
            v6 = [
              { address = "2a03:3b40:42:2:01::1"; as = 4200001901; }
              { address = "2a03:3b40:42:3:01::1"; as = 4200001902; }
            ];
          };
        };

        virtIP = "172.16.0.26/32";
      };
    };

    node2 = {
      nodeId = 401;

      networking = {
        netboot = {
          enable = true;
          macs = [
            "0c:c4:7a:ab:b4:43"
            "0c:c4:7a:ab:b4:42"
          ];
        };

        interfaces = {
          names= {
            teng0 = "0c:c4:7a:88:70:14";
            teng1 = "0c:c4:7a:88:70:15";
          };
          addresses = {
            teng0 = { v4 = [ "172.16.251.6/30" ]; v6 = [ "2a03:3b40:42:2:02::2/80" ]; };
            teng1 = { v4 = [ "172.16.250.6/30" ]; v6 = [ "2a03:3b40:42:3:02::2/80" ]; };
          };
        };

        bird = {
          as = 4200001002;
          routerId = "172.16.251.6";
          bgpNeighbours = {
            v4 = [
              { address = "172.16.251.5"; as = 4200001901; }
              { address = "172.16.250.5"; as = 4200001902; }
            ];
            v6 = [
              { address = "2a03:3b40:42:2:02::1"; as = 4200001901; }
              { address = "2a03:3b40:42:3:02::1"; as = 4200001902; }
            ];
          };
        };

        virtIP = "172.16.0.66/32";
      };
    };
  };
}
