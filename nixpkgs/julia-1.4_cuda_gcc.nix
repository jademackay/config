{ pkgs ? import <nixpkgs> {} }:
let
	juliatree=pkgs.stdenv.mkDerivation {
		name = "juliatree";
		src = pkgs.fetchzip {
			url="https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz";
			sha256="sha256:12bk8qjqgfxi72bf3shw70vkfzxd9kmdhbkw78i5zfkjfkjaqdij";
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
      #zlib # for conda.exe
			curl
			qt4
			coreutils
			ourpython
      # Flux deps
      cudnn
      cudatoolkit # for nvcc
      #cudnn_cudatoolkit_10_0
      #linuxPackages.nvidia_x11
      #openblas
      # MLJ deps
      gcc
      binutils-unwrapped
		]
	);
  profile = ''
    export PATH=${juliatree}/julia/bin:$PATH
    export CUDA_ROOT=${pkgs.cudatoolkit}
    export PYTHONPATH=${ourpython}/lib/python3.7/site-packages  
    export LIBRARY_PATH=${pkgs.gcc}:$LIBRARY_PATH
    export PATH=${pkgs.binutils-unwrapped}/bin:$PATH

  '';     
  #export PYTHON=${ourpython}/bin/python  
  runScript="julia";
}
  
