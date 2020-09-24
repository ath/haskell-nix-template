{ mkDerivation, aeson, cabal-install, cabal2nix, pkgs, stdenv }:
mkDerivation {
  pname = "ProjectName";
  version = "0.1.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  buildTools = [ cabal-install cabal2nix pkgs.curl pkgs.nix-prefetch-git ];
  executableHaskellDepends = [ aeson ];
  license = stdenv.lib.licenses.bsd3;
}
