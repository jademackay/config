{ pkgs ? import <nixpkgs> {} }:
let
	juliatree=pkgs.stdenv.mkDerivation {
		name = "juliatree";
    version = "1.5.0";
    src = pkgs.fetchzip {
      url="https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.0-rc2-linux-x86_64.tar.gz";
      #sha256="sha256:b830c75e0839902337a59b0eb3db73b8d1d79c2a548b32b204c82486748bd78c";
      sha256="sha256:1q8s5fk8iww8zpizy7d7r2sakmj96qdnlwbaqp0pkwxlsag5max8";
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
  ourpython=(pkgs.python37.withPackages (ps: [ps.matplotlib ps.gym]));
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
      # #cudnn_cudatoolkit_10_0
      # #linuxPackages.nvidia_x11
      # #openblas
      # MLJ deps
      gcc
      binutils-unwrapped
      # ForneyLab.jl viz
      graphviz 
      # Stan.jl
      cmdstan # change this to local cmdstan bc stan execution writes to
      # $CMDSTAN_HOME/stan/src/stan/model/
      # Fairness.jl:
      ipopt
      # TikzPictures.jl:
      texlive.combined.scheme-full # full bc already installed
      # Conda.jl: (still faililing)
      zlib
		]
	);
  profile = ''
    export PATH=${juliatree}/julia/bin:$PATH
    export CUDA_ROOT=${pkgs.cudatoolkit}
    export PYTHONPATH=${ourpython}/lib/python3.7/site-packages  
    export LIBRARY_PATH=${pkgs.gcc}:$LIBRARY_PATH 
    export LIBRARY_PATH=${pkgs.ipopt}:$LIBRARY_PATH
    export LIBRARY_PATH=${pkgs.zlib}:$LIBRARY_PATH
    export PATH=${pkgs.binutils-unwrapped}/bin:$PATH
    export JULIA_CMDSTAN_HOME=${pkgs.cmdstan}/opt/cmdstan
  '';     
  runScript="julia";
}
  
