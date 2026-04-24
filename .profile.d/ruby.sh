# Ruby
# 
# install rbenv via one of: 
#   nix profile add nixpkgs#rbenv
#   git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# install ruby-build via: 
#   git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# macos notes
# 
# LibYAML
# 
# installed libyaml 0.2.5 at /usr/local/libyaml
#
# /usr/local/libyaml/include/yaml.h
# /usr/local/libyaml/lib/libyaml-0.2.dylib
# /usr/local/libyaml/lib/libyaml.dylib
# /usr/local/libyaml/lib/libyaml.la
# 
# build new rubies w/ RUBY_CONFIGURE_OPTS=--with-libyaml-dir=/usr/local/libyaml/ rbenv install x.x.x

# linux notes
# 
# install dependency packages: libssl-dev libyaml-dev

# Configure rbenv
# the following is generated via: ~/.rbenv/bin/rbenv init - bash
if [ -x "$(command -v rbenv)" ]; then
    eval "$(rbenv init - --no-rehash bash)"
fi
