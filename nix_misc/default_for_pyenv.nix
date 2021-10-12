{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "mypackage";
  buildInputs = [
    pkgs.python38Packages.pip
    pkgs.python38Packages.virtualenv
  ];
    shellHook = ''
    virtualenv mypackage
    source mypackage/bin/activate
    pip install pytest
    pip install -e ./mypackage
    '';
}
  
