{ pkgs ? import <nixpkgs> {} }:
let
	juliatree=pkgs.stdenv.mkDerivation {
		name = "juliatree";
		src = pkgs.fetchzip {
			url="https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.0-linux-x86_64.tar.gz";
			sha256="14iqglqj61yk41jq9k3blc71kgdzx17ylh4f96mq6dawbwqvxnlc";
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
  ourpython=(pkgs.python37.withPackages (ps: [ps.matplotlib ps.jupyter]));
  ldconfigWrapper = pkgs.stdenv.mkDerivation {
      name="ldconfig-env";
      nativeBuildInputs = [ pkgs.makeWrapper ];
      phases = [ "installPhase" "fixupPhase" ];
      installPhase = ''
      makeWrapper ${pkgs.glibc.bin}/bin/ldconfig $out/sbin/ldconfig --add-flags "-C /usr/ld.so.cache"
    '';
  };
  notofonts=pkgs.noto-fonts;
in
pkgs.buildFHSUserEnv {
  name = "julia";
  targetPkgs = pkgs: (
		with pkgs;
		[
			ldconfigWrapper
			juliatree
			curl
			qt4
			coreutils
			SDL2
			SDL2_ttf
			SDL2_mixer
			zlib
			ourpython
			netcdf
			gcc
			gnumake
			binutils-unwrapped
      fontconfig
		] 
	);
  profile = ''
    export PATH=${juliatree}/julia/bin:${ldconfigWrapper}/bin:$PATH
    export PYTHONPATH=${ourpython}/lib/python3.7/site-packages
  '';
  extraBuildCommands = ''
      echo "$out/lib" > $out/usr/ld.so.conf
      ldconfig -f $out/usr/ld.so.conf -C $out/usr/ld.so.cache
      mkdir -p $out/usr/local/share/fonts
      ln -s ${notofonts}/share $out/usr/local/share/fonts/noto-fonts
    '';
  runScript="julia";
}
  
  
  
