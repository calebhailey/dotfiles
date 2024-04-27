# NixOS
# 
# installed via: sh <(curl -L https://nixos.org/nix/install)
# 
# install script performs the following:
# - make sure your computer doesn't already have Nix files
#   (if it does, I will tell you how to clean them up.)
# - create local users (see the list above for the users I'll make)
# - create a local group (nixbld)
# - install Nix in to /nix
# - create a configuration file in /etc/nix
# - set up the "default profile" by creating some Nix-related files in
#   /var/root
# - back up /etc/bashrc to /etc/bashrc.backup-before-nix
# - update /etc/bashrc to include some Nix configuration
# - back up /etc/zshrc to /etc/zshrc.backup-before-nix
# - update /etc/zshrc to include some Nix configuration
# - create a Nix volume and a LaunchDaemon to mount it
# - create a LaunchDaemon (at /Library/LaunchDaemons/org.nixos.nix-daemon.plist) for nix-daemon
