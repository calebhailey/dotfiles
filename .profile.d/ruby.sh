# Ruby
# 
# installed rbenv via: git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# installed ruby-build via: git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

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

# Configure rbenv
# the following is generated via: ~/.rbenv/bin/rbenv init - bash
export PATH="${HOME}/.rbenv/bin:${PATH}"
export PATH="${HOME}/.rbenv/shims:${PATH}"
export RBENV_SHELL=bash
source "${HOME}/.rbenv/completions/rbenv.bash"
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}
