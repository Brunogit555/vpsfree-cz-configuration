{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.web;
  domain = cfg.domain;
  pinned = import ../pinned.nix { inherit lib pkgs; };

  docs = pkgs.runCommand "docsroot" { buildInputs = [ pinned.nixpkgsVpsFree.mkdocs ]; } ''
    mkdir -p $out
    pushd ${pinned.vpsadminosSrc}
    mkdocs build --site-dir $out
    popd
  '';

  buildMan = component: pkgs.runCommand "${replaceStrings ["/"] ["_"] component}_man" { buildInputs = [ pinned.vpsadminosDocsPkgs.osctl-env-exec pkgs.git ]; } ''
    mkdir man
    cp -R ${pinned.vpsadminosSrc} vpsadminos
    chmod -R +w vpsadminos
    pushd vpsadminos/${component}
      touch man/style.css
      osctl-env-exec rake md2man:web
      mkdir $out
      cp -R man/* $out/
    popd
    # hack around md2man unable to generate style.css due to creating
    # it readonly, which we workaround with touch which results in empty style..
    rm -rf $out/style.css
    cp $(osctl-env-exec 'bash -c "echo $BUNDLE_PATH"')/gems/md2man-*/lib/md2man/rakefile/style.css $out/style.css
  '';

  man = pkgs.runCommand "manroot" { } ''
    mkdir $out
    ln -s ${buildMan "osctl"} $out/osctl
    ln -s ${buildMan "converter"} $out/converter
    ln -s ${buildMan "osup"} $out/osup
    ln -s ${buildMan "svctl"} $out/svctl
  '';

  ref = pkgs.runCommand "refroot" { buildInputs = [ pinned.vpsadminosDocsPkgs.osctl-env-exec pkgs.git ]; } ''
    cp -R ${pinned.vpsadminosSrc} vpsadminos
    chmod -R +w vpsadminos
    mkdir $out
    pushd vpsadminos
      for gem in libosctl osctl osctl-image osctl-repo osctld converter svctl; do
        pushd $gem
          mkdir -p $out/$gem
          YARD_OUTPUT=$out/$gem osctl-env-exec rake yard
          test -f $out/$gem/index.html || (echo "gem $gem didn't produce index.html" && exit 1);
        popd
      done
    popd
  '';

  iso =  pkgs.runCommand "isoroot" {} ''
    mkdir $out
    for iso in ${concatStringsSep " " cfg.isoImages}; do
      fpath=$iso/iso/*.iso
      name=$( basename $fpath )
      ln -s $fpath $out/$name
      sha256sum $fpath > $out/$name.sha256
    done
  '';

  # XXX: if we decide to sign templates as well
  #templates_root = pkgs.runCommand "templatesroot" { buildInputs = [ pkgs.openssl ]; } ''
  #  mkdir -pv $out

  #  function signit {
  #    openssl cms -sign -binary -noattr -in $1 -signer ${/secrets/ca/codesign.crt} -inkey ${/secrets/ca/codesign.key} -certfile ${/secrets/ca/root.pem} -outform DER -out ''${1}.sig
  #  }
  #  signit $out/XYZ
  #'';

in
{
  options = {
    web = rec {
      domain = mkOption {
        type = types.str;
        description = "Domain of the webserver";
      };

      acmeSSL = mkOption {
        type = types.bool;
        description = "Enable ACME and SSL for nginx";
        default = false;
      };

      isoImages = mkOption {
        type = types.listOf types.path;
        description = "ISO images to publish";
        default = [];
      };
    };
  };

  config = {
    networking.firewall.allowedTCPPorts = [ 80 ] ++ lib.optional cfg.acmeSSL 443;

    services.nginx = {
      enable = true;
      recommendedTlsSettings = cfg.acmeSSL;
      recommendedProxySettings = true;
      commonHttpConfig = "server_names_hash_bucket_size 32;";
      virtualHosts = {
        "${domain}" = {
          root = docs;
          default = true;
          forceSSL = cfg.acmeSSL;
          enableACME = cfg.acmeSSL;
        };

        "templates.${domain}" = {
          root = "/srv/templates";
          forceSSL = cfg.acmeSSL;
          enableACME = cfg.acmeSSL;
          locations = {
            "/" = {
              extraConfig = "autoindex on;";
            };
          };
        };

        "images.${domain}" = {
          root = "/srv/images";
          forceSSL = cfg.acmeSSL;
          enableACME = cfg.acmeSSL;
          locations = {
            "/" = {
              extraConfig = "autoindex on;";
            };
          };
        };

        "man.${domain}" = {
          root = man;
          forceSSL = cfg.acmeSSL;
          enableACME = cfg.acmeSSL;
          locations = {
            "/" = {
              extraConfig = "autoindex on;";
            };
          };
        };

        "ref.${domain}" = {
          root = ref;
          forceSSL = cfg.acmeSSL;
          enableACME = cfg.acmeSSL;
          locations = {
            "/" = {
              extraConfig = "autoindex on;";
            };
          };
        };

        "iso.${domain}" = {
          root = iso;
          forceSSL = cfg.acmeSSL;
          enableACME = cfg.acmeSSL;
          locations = {
            "/" = {
              extraConfig = "autoindex on;";
            };
          };
        };

      };
    };

  };
}
