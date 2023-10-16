.PHONY: clean format home home-build home-switch system

clean:
	sudo nix-collect-garbage -d

format:
	nix fmt

home: home-build home-switch

home-build:
	home-manager build --flake .

home-switch:
	home-manager switch --flake .

system:
	sudo nixos-rebuild switch --flake .

