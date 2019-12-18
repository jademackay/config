{ pkgs ? import <nixpkgs> {} }:
let
	juliatree=pkgs.stdenv.mkDerivation {
		name = "juliatree";
		src = pkgs.fetchzip {
			url="https://julialang-s3.julialang.org/bin/linux/x64/1.3/julia-1.3.0-linux-x86_64.tar.gz";
			sha256="06ij9vzq0lgm0wdwsxsfk8g5ns298zn71qbr06l6qqz2vggbyzqj";
		};
		buildPhase = ''
		           	'';
		installPhase = ''
		          mkdir -p $out
					    cp -r $src $out/julia
					    '';         
		fixupPhase = ''
					    '' ;
  };
  ourpython=(pkgs.python37.withPackages (ps: [ps.matplotlib]));
in
pkgs.buildFHSUserEnv {
  name = "julia";
  targetPkgs = pkgs: (
		with pkgs;
		[
			juliatree
			curl
			qt4
			coreutils
			#ourpython
      # Flux deps
      cudnn
      cudatoolkit # for nvcc
      #cudnn_cudatoolkit_10_0
      #linuxPackages.nvidia_x11
      #openblas
		]
	);
  profile = ''
    export PATH=${juliatree}/julia/bin:$PATH
    export PYTHONPATH=${ourpython}/lib/python3.7/site-packages
    export CUDA_ROOT=${pkgs.cudatoolkit}
  '';     
  runScript="julia";
}
  
