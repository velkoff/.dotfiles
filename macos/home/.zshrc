export PATH="$HOME/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="col -b | nvim -MR - "
export LANG=en_US.UTF-8
export EZA_CONFIG_DIR="$HOME/.config/eza"

unset LS_COLORS

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="theunraveler"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/plugins
plugins=(
    git
    zsh-autosuggestions
    fzf
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# eza
if command -v eza >/dev/null; then
    # List
    alias l="eza --long --all --group-directories-first --git --no-user --header --icons=auto"
    alias ls="eza --group-directories-first --no-user --icons=auto"
    # Tree view
    alias lt="eza -T --level=2 --no-user --hyperlink=auto --icons=auto"
    # Newest
    alias lT="eza --long --all --sort=newest --git --no-user --header --icons=auto"
    # By size
    alias lS="eza --long --all --sort=size --git --no-user --header --icons=auto"
    # By size (total size recursive)
    alias lSS="eza --long --all --sort=size --git --no-user --total-size --header --icons=auto"
fi

# Local machine specific
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
