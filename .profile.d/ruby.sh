# Ruby
# 
# installed rbenv via: git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# installed ruby-build via: git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
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
