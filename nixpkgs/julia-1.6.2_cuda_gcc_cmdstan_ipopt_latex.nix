{ pkgs ? import <nixpkgs> {} }:
let
	juliatree=pkgs.stdenv.mkDerivation {
		name = "juliatree";
    version = "1.6.2";
    src = pkgs.fetchzip {
      url="https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.2-linux-x86_64.tar.gz";
      sha256="sha256:0dhwllf8zjggfzd0h63pxpcp1dwiq4i8i3fiasz61sfvmkyshh83";
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
  ourpython=(pkgs.python39.withPackages (ps: [ps.matplotlib]));
  # ATTN: python version must conform with the export PYTHONPATH path in `profile` below
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
      # Conda.jl: (still failing)
      zlib
      conda
      adoptopenjdk-jre-bin
		]
	);
  profile = ''
    export PATH=${juliatree}/julia/bin:$PATH
    export CUDA_ROOT=${pkgs.cudatoolkit}
    export PYTHONPATH=${ourpython}/lib/python3.9/site-packages  
    export PYTHON=${ourpython}/bin/python
    export LIBRARY_PATH=${pkgs.gcc}:$LIBRARY_PATH 
    export LIBRARY_PATH=${pkgs.ipopt}:$LIBRARY_PATH
    export LIBRARY_PATH=${pkgs.zlib}:$LIBRARY_PATH
    export LD_LIBRARY_PATH=${pkgs.zlib}:$LD_LIBRARY_PATH
    export PATH=${pkgs.binutils-unwrapped}/bin:$PATH
    export JULIA_CMDSTAN_HOME=${pkgs.cmdstan}/opt/cmdstan
  '';     
  runScript="julia";
  # TODO:
  # * Add Revise and Documenter and Plots and and PyPlot and PyCall here
}
  
