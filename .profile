# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# load path.d files
load_user_paths() {
    local file
    local path
    local user_paths=""

    [ -d "${HOME}/.paths.d" ] || return

    for file in "${HOME}/.paths.d/"*; do
        [ -f "$file" ] || continue

        while IFS= read -r path || [ -n "$path" ]; do
            [ -n "$path" ] || continue
            [ "${path#\#}" = "$path" ] || continue

            case "$path" in
                "~/"*) path="${HOME}/${path#"~/"}" ;;
            esac

            [ -d "$path" ] || continue

            case ":${user_paths}:${PATH}:" in
                *":${path}:"*) continue ;;
            esac

            if [ -z "$user_paths" ]; then
                user_paths="$path"
            else
                user_paths="${user_paths}:${path}"
            fi
        done < "$file"
    done

    [ -n "$user_paths" ] || return

    PATH="${user_paths}:${PATH}"
    export PATH
}

load_user_scripts() {
    local file

    [ -d "${HOME}/.profile.d" ] || return

    for file in "${HOME}/.profile.d/"*; do
        [ -f "$file" ] || continue
        echo "source \"$(basename "$file")\" added"
        source "$file"
    done

}

load_user_paths
load_user_scripts
