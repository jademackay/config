

```
nix-env -f julia-1.4_cuda_gcc.nix -i julia
```

https://stackoverflow.com/questions/51929712/nix-and-gcc-cannot-find-crt1-o

In short, things are done differently with Nix. Instead of installing tools and libraries like you'd do with most distros, when using Nix you create a "Nix expression" which declares your build dependencies and instructions for compiling your program. For example, say you have a hello.cc with this source code:

#include <iostream>
using namespace std;

int main() 
{
    cout << "Hello, World!";
    return 0;
}

To compile it with Nix you can use a default.nix file (in the same directory) like this:

let
    pkgs = (import <nixpkgs>) {};
    gcc = pkgs.gcc;
    stdenv = pkgs.stdenv;
in
    stdenv.mkDerivation {
        name = "hello";
        version = "1.0.0";
        src = ./.;
        phases = [ "unpackPhase" "buildPhase" "installPhase" ];

        buildPhase = ''
            ${gcc}/bin/g++ -std=c++11 -x c++ hello.cc -o hello
        '';

        installPhase = ''
            mkdir -p $out/bin
            cp hello $out/bin
        '';
    }

...which you can build like this: nix build

You'll end up with a ./result symbolic link which points to the $out directory used above. The installPhase above copies the binary to $out/bin, so the program can be executed by running ./result/bin/hello

The Nix language is described in its documentation and you can get an overview of how to use it to build things from the Nixpkgs documentation.
