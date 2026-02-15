#!/usr/bin/env bash

set -e

# Sync a particular module or anything
sync() {
    echo "sync"
}


MAPPINGS=()
# Sets up a mapping for a path to a path.
# Will be copied each time.
map_env() {
    [ -z "$1" ] && error "Missing argument" "Group cannot be blank"
    [ -z "$2" ] && error "Missing argument" "FROM cannot be blank"
    [ -z "$3" ] && error "Missing argument" "TO cannot be blank"
    [ ! -e "$2" ] && error "No such file in config: $1"
    MAPPINGS+=("$1;$2;$3")
}

# Backup current state in the mapping to a given location.
# Will contain the contents of this project.
backup() {
    [ -z $1 ] && error "Missing argument" "Backup dir is required"
    printf 'RAW: [%s]\n' "$1"
    local backup_dir="$(expand_path "$1")"
    echo "$backup_dir"
    shift 1

    [ "$#" -eq 0 ] && error "Missing argument" "Groups are missing"

    mkdir -p "$backup_dir" || error "Backup error" "Cannot create backup dir"

    for group in "$@"; do
        for entry in "${MAPPINGS[@]}"; do
            IFS=";" read -r map_group from to <<< "$entry"

            [ "$map_group" != "$group" ] && continue

            expanded_to="$(expand_path "$to")"
            [ ! -e "$expanded_to" ] && continue

            rel_path="${from#./}"
            dest="$backup_dir/$rel_path"

            if [ -d "$expanded_to" ]; then
                mkdir -p "$dest"
                cp -a "$expanded_to"/. "$dest"/
            else
                echo "File $(dirname "$dest")"
                mkdir -p "$(dirname "$dest")"
                cp -a "$expanded_to" "$dest"
            fi
        done
    done
}

# Usage:
# error "This is an error"
# error "This is an error" "Yes it is"
error() {
    local msg="$1"
    local subtext="$2"

    printf "Error: %s%s\n" \
        "$msg"\
        "${subtext:+ - $subtext}" >&2
    exit 1
}

expand_path() {
    case "$1" in
        '~') printf '%s\n' "$HOME" ;;
        '~/'*) printf '%s/%s\n' "$HOME" "${1#"~/"}" ;;
        *) printf '%s\n' "$1" ;;
    esac
}

map_env "nvim" "./nvim/" "~/.config/nvim"
map_env "tmux" "./tmux/.tmux.conf" "~/.tmux.conf"
map_env "shell" "./shell/.bashrc" "~/.bashrc"
map_env "shell" "./shell/.bash_profile" "~/.bash_profile"

backup "~/.dotfiles_backup" "shell" "nvim"
