
nixpkgs:
	mkdir -p $(HOME)/.config/nixpkgs
	cp nixpks/config.nix $(HOME)/.config/nixpkgs

emacs-nixos:
	mkdir -p $(HOME)/.config/nixpkgs
	cp nixpkgs/emacs.nix

i3status: ./i3status/config_goldchain
	mkdir -p $(HOME)/.config/i3status
	cp ./i3status/config_goldchain $(HOME)/.config/i3status/config

i3: ./i3/config  ./i3/i3exit
# ispath ? mv ~/.config/i3/config ~/.config/i3/config.bak
	touch $(HOME)/.config/i3/config 
	mv $(HOME)/.config/i3/config $(HOME)/.config/i3/config.bak.`date -d "today" +"%Y%m%d%H%M"`
	cp ./i3/config $(HOME)/.config/i3/config
	cp ./i3/i3exit $(HOME)/.config/i3/config

emacs: ./emacs/emacs emacs-theme
	mkdir -p $(HOME)/emacs_backups
	touch $(HOME)/.emacs
	mv $(HOME)/.emacs $(HOME)/.emacs.bak.`date -d "today" +"%Y%m%d%H%M"`
	cp ./emacs/emacs $(HOME)/.emacs
        #emacs -e "(progn (package-initialize)(package-install 'color-theme))"

emacs-theme:
	#cd .. && git clone https://github.com/emacsmirror/tangotango-theme.git
	mkdir $(HOME)/.emacs.d/color-themes
	cp ../tangotango-theme/tangotango-theme.el $(HOME)/.emacs.d/color-themes/

receive-nixos:
	cp /etc/nixos/configuration.nix nixos/configuration.nix

