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
  ourpython=(pkgs.python38.withPackages (ps: [ps.matplotlib]));
  # ATTN: python version must conform with the export PYTHONPATH path in `profile` below
in
pkgs.buildFHSUserEnv {
  name = "julia";
  targetPkgs = pkgs: (
		with pkgs;
		[
			juliatree
			curl
			qt4
      #gtk3
      gtk4
      #gtk2
      font-manager
      cairo
      #gdk-pixbuf
      gdk-pixbuf-xlib
      libadwaita
      fontconfig
      #gtk2
			coreutils
			ourpython
      gcc
      binutils-unwrapped
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
      libxml2
      git
      docker
		]
	);
  profile = ''
    export PATH=${juliatree}/julia/bin:$PATH
    export PYTHONPATH=${ourpython}/lib/python3.8/site-packages  
    export PYTHON=${ourpython}/bin/python
    export LIBRARY_PATH=${pkgs.gcc}:$LIBRARY_PATH 
    export LIBRARY_PATH=${pkgs.ipopt}:$LIBRARY_PATH
    export LIBRARY_PATH=${pkgs.zlib}:$LIBRARY_PATH
    export LD_LIBRARY_PATH=${pkgs.zlib}:$LD_LIBRARY_PATH
    export PATH=${pkgs.binutils-unwrapped}/bin:$PATH
    export JULIA_CMDSTAN_HOME=${pkgs.cmdstan}/opt/cmdstan
  '';

  #run(`fc-match`)
  runScript="julia";
  # TODO:
  # * Add Revise and Documenter and Plots and and PyPlot and PyCall here
}
  
