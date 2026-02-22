#!/usr/bin/env bash

# Get the directory of the script file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Change to that directory
cd "$SCRIPT_DIR" || exit 1
set -e

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

mirror() {
    local src="$1"
    local dest="$2"

    if [[ ! -e "$src" ]]; then
        error "Source '$src' doesn't exist"
    fi

    if [[ -d "$src" ]]; then
        mkdir -p "$dest"
        cp -a "$src"/. "$dest"/
    else
        mkdir -p "$(dirname "$dest")"
        cp -a "$src" "$dest"
    fi
}

error() { printf "\033[1;31mError: %s\033[0m%s\n" "$1" "${2:+ - $2}" >&2; exit 1; }
warn() { printf "\033[1;33mWarning: %s\033[0m%s\n" "$1" "${2:+ - $2}" >&2; }

expand_path() {
    case "$1" in
        '~') printf '%s\n' "$HOME" ;;
        '~/'*) printf '%s/%s\n' "$HOME" "${1#"~/"}" ;;
        *) printf '%s\n' "$1" ;;
    esac
}

sync() {
    [[ "$#" -eq 0 ]] && error "Missing argument" "Groups are missing"

    for pattern in "$@"; do
        for entry in "${MAPPINGS[@]}"; do
            IFS=";" read -r map_group from to <<< "$entry"

            [[ ! $map_group == $pattern ]] && continue

            dest="$(expand_path "$to")"
            [[ ! -e "$src" ]] && continue

            rel_path="${from#"./"}"
            src="$SCRIPT_DIR/$rel_path"

            mirror "$src" "$dest" || warn "Could not sync" "Failed for:'$map_group':'$from'->'$to'"
        done
    done
}

# Backup current state in the mapping to a given location.
# Will contain the contents of this project.
backup() {
    [[ -z $1 ]] && error "Missing argument" "Backup dir is required"
    local backup_dir="$(expand_path "$1")"
    shift 1

    [[ "$#" -eq 0 ]] && error "Missing argument" "Groups are missing"

    mkdir -p "$backup_dir" || error "Backup error" "Cannot create backup dir"

    for pattern in "$@"; do
        for entry in "${MAPPINGS[@]}"; do
            IFS=";" read -r map_group from to <<< "$entry"

            [[ ! $map_group == $pattern ]] && continue

            src="$(expand_path "$to")"
            [[ ! -e "$src" ]] && continue

            rel_path="${from#"./"}"
            dest="$backup_dir/$rel_path"

            mirror "$src" "$dest" || warn "Could not backup" "Failed for:'$map_group':'$from'->'$to'"
        done
    done
}

usage() {
    cat <<EOF
    Usage: $(basename "$0") [options] group1 group2 ...

    Options:
    -s          Sync (Project -> System)
    -b <dir>    Backup (System -> <dir>)
    -c <file>   Config file (default: ./config.sh)
    -h          Show this help
EOF
exit 0
}


CONFIG_FILE="$SCRIPT_DIR/config.sh"
DO_SYNC=false
DO_BACKUP=false
BACKUP_PATH=""

# Parse options
while getopts "sb:c:h" opt; do
    case "$opt" in
        s) DO_SYNC=true ;;
        b) DO_BACKUP=true; BACKUP_PATH="$OPTARG" ;;
        c) CONFIG_FILE="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done
shift $((OPTIND -1))

if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    error "Config file not found" "$CONFIG_FILE"
fi

if [ "$DO_SYNC" = false ] && [ "$DO_BACKUP" = false ]; then
    usage
fi

if [ "$DO_BACKUP" = true ]; then
    backup "$BACKUP_PATH" "$@"
fi

# 4. Execute Sync SECOND (if requested)
if [ "$DO_SYNC" = true ]; then
    sync "$@"
fi
