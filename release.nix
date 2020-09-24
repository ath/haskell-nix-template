let
  bootstrap = import <nixpkgs> { };

  nixpkgs = builtins.fromJSON (builtins.readFile ./nix/pinnedNixPkgs_20.09.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

config = {
    allowBroken = true;

    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          ProjectName =
            haskellPackagesNew.callPackage ./project.nix { };

#          base =
#            haskellPackagesNew.callPackage ./nix/deps/base.nix { };

        };
      };
    };
  };

  pkgs = import src { inherit config; };

in
  {
    releaseEnv = pkgs.haskellPackages.ProjectName;
  }
