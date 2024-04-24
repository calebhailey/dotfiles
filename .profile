# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# load profile.d scripts
if [ -d "${HOME}/.profile.d" ]; then
    for FILE in "${HOME}/.profile.d/"*; do 
        if [ -f "${FILE}" ]; then
            echo "source $(basename ${FILE})"
            source ${FILE}
        fi
    done
fi;

# load profile.d/private scripts
if [ -d "${HOME}/.profile.d/private" ]; then
    for FILE in "${HOME}/.profile.d/private/"*; do 
        if [ -f "${FILE}" ]; then
            source ${FILE}
        fi
    done
fi;

# secrets
if [ -d "${HOME}/.profile.d/secrets" ]; then
    for FILE in "${HOME}/.profile.d/secrets/"*; do 
        if [ -f "${FILE}" ]; then
            source ${FILE}
        fi
    done
fi;

# rejoin active tmux sessions (if any)
if [ $(which tmux) ]; then
  if [ !$(tmux list-sessions > /dev/null 2>&1) ] && [ -z $TMUX ]; then 
    tmux attach -d
  fi;
fi;
