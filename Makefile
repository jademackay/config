
install-nix:
	curl -L https://nixos.org/nix/install | sh

# TODO: install emacs and ispell with nix-env

nixpkgs:
	mkdir -p $(HOME)/.config/nixpkgs
	cp nixpkgs/config.nix $(HOME)/.config/nixpkgs

nixos-receive:
	cp /etc/nixos/configuration.nix nixos/configuration.nix
	cp /etc/nixos/hardware-configuration.nix nixos/hardware-configuration.nix

nixos-update:
	sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.`date -d "today" +"%Y%m%d%H%M"`
	sudo cp nixos/configuration.nix /etc/nixos/configuration.nix

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

# emacs-julia:

emacs-config: ./emacs/emacs
	touch $(HOME)/.emacs
	mv $(HOME)/.emacs $(HOME)/.emacs.bak.`date -d "today" +"%Y%m%d%H%M"`
	cp ./emacs/emacs $(HOME)/.emacs

# emacs-theme:
# 	cd .. && git clone https://github.com/emacsmirror/tangotango-theme.git
# 	mkdir $(HOME)/.emacs.d/color-themes
# 	cp ../tangotango-theme/tangotango-theme.el $(HOME)/.emacs.d/color-themes/

# $(HOME)/.emacs.d/color-themes/tangotango-theme:
# 	mkdir -p $(HOME)/.emacs.d/color-themes
# 	git clone https://github.com/emacsmirror/tangotango-theme.git $(HOME)/.emacs.d/color-themes/tangotango-theme

#emacs-setup: emacs-config $(HOME)/.emacs.d/color-themes/tangotango-theme
emacs-setup: emacs-config 
	mkdir -p $(HOME)/emacs_backups
	touch $(HOME)/.emacs
#	emacs -e "(progn (package-initialize)(package-install 'color-theme))"
#	emacs -e "(progn (package-initialize)(package-install 'nix-mode))"	
#	emacs -e "(progn (package-initialize)(package-install 'julia-mode))"	
#emacs -e "(progn (package-initialize)(package-install 'packagename))"
#(mapc 'package-install install-list)

tmux-plugins: 
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux-setup: 
	cp tmux/tmux.conf $(HOME)/.tmux.conf
	tmux source ~/.tmux.conf

oh-my-zsh:
	sh -c $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)
