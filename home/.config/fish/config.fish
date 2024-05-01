## Convenience Functions
function add_path_if_exists
    if test -d "$argv"
        fish_add_path "$argv"
    end
end

function command_exists
    command --query "$argv"
end


## Putting paths even in non-interactive shells makes Apps Happy™
add_path_if_exists ~/go
add_path_if_exists ~/bin
add_path_if_exists ~/go/bin
add_path_if_exists ~/.cargo/bin
add_path_if_exists ~/Applications/
add_path_if_exists /usr/local/bin
add_path_if_exists /opt/homebrew/bin
add_path_if_exists /home/linuxbrew/.linuxbrew/bin

# Mosh Server settings are needed at init
# make `killall -USR1 mosh-server` only kill sessions disconected for X seconds
set -gx MOSH_SERVER_SIGNAL_TMOUT 60
# Clean up any session that has not been connected to in 30 days
set -gx MOSH_SERVER_NETWORK_TMOUT 2592000

# Always utf-8
set -gx LANG en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8

# Putting this in non-interactive makes Apps use 1Password
# The setting is exported instead of in ssh/config so I can have the test and fallback if this isn't set up
test -S ~/.1password/agent.sock; and set -gx SSH_AUTH_SOCK ~/.1password/agent.sock

if status is-interactive
    # Commands to run in interactive sessions can go here

    #
    ## Paths
    #
    # Brewpaths
    if command_exists brew
        brew shellenv | source

        ## brew --prefix is way too slow in 4.0 so hardcode
        function _brew_prefix
            printf "$HOMEBREW_PREFIX/opt/$1"
        end

        ## Brew overlays
        set -l apps openssh whois curl libpq
        for app in $apps
            add_path_if_exists "(_brew_prefix app)/bin"
        end
    end

    # Homeshick
    source ~/.homesick/repos/homeshick/homeshick.fish
    source ~/.homesick/repos/homeshick/completions/homeshick.fish

    # asdf-vm
    if test -d ~/.asdf/asdf.fish
        source ~/.asdf/asdf.fish
        mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
        set -gx ASDF_GOLANG_MOD_VERSION_ENABLED false
        set -gex RUBY_CONFIGURE_OPTS
    end

    # DirEN
    if command_exists direnv
        direnv hook fish | source
        alias tmux "direnv exec / tmux"
    end

    # Wezterm
    add_path_if_exists "$WEZTERM_EXECUTABLE_DIR"

    # Generic overlays
    if command_exists bat
        set -gx BAT_THEME gruvbox-dark
    end

    if command_exists eza
        alias ls=eza
        alias la="eza -a"
        alias ll="eza -l"
        alias lla="eza -la"
        alias tree="eza --tree"
    end

    if command_exists fzf
        fzf --fish | source
        set -gx FZF_DEFAULT_COMMAND 'fd --follow --hidden --type f'
        set -gx FZF_CTRL_T_COMMAND 'fd --follow --hidden'
        set -gx FZF_ALT_C_COMMAND 'fd --follow --hidden --type d'
    end

    if command_exists yazi
        function yy --wraps yazi --description "Quick Yazi with cd"
            set tmp (mktemp -t "yazi-cwd.XXXXXX")
            yazi $argv --cwd-file="$tmp"
            if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                cd -- "$cwd"
            end
            rm -f -- "$tmp"
        end
    end

    if command_exists zoxide
        zoxide init fish | source
    end

    #
    ## Aliases
    #
    abbr --add ce chef exec
    abbr --add cet chef exec thor
    abbr --add cek chef exec knife

    abbr --add cl clear

    abbr --add g git
    abbr --add G git

    function lg --wraps lazygit
        XDG_CONFIG_HOME=~/.config lazygit
    end

    function lzd --wraps lazydocker
        XDG_CONFIG_HOME=~/.config lazydocker
    end

    abbr --add tm tmux new-session -A -c ~
    abbr --add tp mosh piper.local -- tmux new-session -A -c ~
    abbr --add tc mosh catra.local -- tmux new-session -A -c ~
    abbr --add tw mosh webby.local -- tmux new-session -A -c ~

    abbr --add venv python3 -m venv
    abbr --add mkvenv python3 -m venv venv
    abbr --add activate source venv/bin/activate

    #
    ## Prompt
    #
    set -g fish_color_user green
    set -g fish_color_host green
    set -g fish_color_cwd green
    set -g __fish_git_prompt_color magenta

end
