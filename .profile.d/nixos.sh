# NixOS
# 
# installed via: https://github.com/DeterminateSystems/nix-installer 
nix-add() {
  nix profile add "nixpkgs#$1"
}
nix-remove() {
  nix profile remove "$1"
}
