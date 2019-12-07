{ pkgs ? import <nixpkgs> {} }:
let
	juliatree=pkgs.stdenv.mkDerivation {
					    name = "juliatree";
					    src = pkgs.fetchzip {
								 url="https://julialang-s3.julialang.org/bin/linux/x64/1.2/julia-1.2.0-linux-x86_64.tar.gz";
								 sha256="04dgic6vhml50h2jl1hxxx9r912jxggamyppfs8pkd0jxb9ygjk7";
					    };
					    buildPhase = ''
					    '';
					    installPhase = ''
					    mkdir -p $out
					    cp -r $src $out/julia
					    '';
					    fixupPhase = ''
					    '';
};
in
 pkgs.buildFHSUserEnv {
   name = "julia";
   targetPkgs = pkgs: (
		       with pkgs; [
				   juliatree
				   curl
				   qt4
				   coreutils
				   cudatoolkit-10.0-cudnn-7.3.1
				   #cudatoolkit-10.0.130
				   ]
		       );
   profile = ''
     export PATH=${juliatree}/julia/bin:$PATH
     '';
     runScript="julia";
 }
 
  
  
