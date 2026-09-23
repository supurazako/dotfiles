# Shared bash environment for Linux hosts.

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export LANGUAGE="${LANGUAGE:-en_US.UTF-8}"
export LANG="${LANG:-$LANGUAGE}"
export LC_ALL="${LC_ALL:-$LANGUAGE}"
export LC_CTYPE="${LC_CTYPE:-$LANGUAGE}"

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export CVSEDITOR="${CVSEDITOR:-$EDITOR}"
export SVN_EDITOR="${SVN_EDITOR:-$EDITOR}"
export GIT_EDITOR="${GIT_EDITOR:-$EDITOR}"

# Reuse the persistent SSH agent managed by keychain. Loading the GitHub key
# here makes SSH_AUTH_SOCK available to both interactive and login shells.
if command -v keychain >/dev/null 2>&1 && [ -f "$HOME/.ssh/id_ed25519" ]; then
    eval "$(keychain --eval --quiet id_ed25519)"
fi

path_prepend() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

path_append() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$PATH:$1" ;;
    esac
}

[ -d "$HOME/.local/bin" ] && path_prepend "$HOME/.local/bin"
[ -d "$HOME/.cargo/bin" ] && path_prepend "$HOME/.cargo/bin"
[ -d "$HOME/.devcontainers/bin" ] && path_prepend "$HOME/.devcontainers/bin"
[ -d "$HOME/bin" ] && path_append "$HOME/bin"
[ -d "$HOME/.volta/bin" ] && path_prepend "$HOME/.volta/bin"

if command -v go >/dev/null 2>&1; then
    go_bin="$(go env GOPATH 2>/dev/null)/bin"
    [ -d "$go_bin" ] && path_append "$go_bin"
    unset go_bin
fi

export PATH
