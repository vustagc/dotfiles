export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
#autoload -U colors && colors
PROMPT='%F{yellow}%~%f %F{gray}>%f '
#PROMPT='%3~ > '
 echo -ne '\e[5 q'

PROMPT_COMMAND='echo -e -n "\\x1b[0 q"'
precmd() { eval "$PROMPT_COMMAND" }

zstyle ':omz:update' mode disabled  # disable automatic updates
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"
plugins=(
    github
    gitignore
    zoxide 
    colored-man-pages
    extract
    history-substring-search
    sudo
    timer
    zsh-interactive-cd
    zsh-autosuggestions
    fast-syntax-highlighting
)

bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down

source $ZSH/oh-my-zsh.sh

# User configuration
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias v="nvim"

alias dot="git -C $DOTS"
alias vimrc="nvim $DOTS/config/nvim/init.lua"
alias shrc="nvim $DOTS/zshrc"
alias fishrc="nvim $DOTS/config/fish/config.fish"
alias hyprrc="nvim $DOTS/config/hypr/"
alias waybarrc="nvim $DOTS/config/waybar/"
alias rofirc="nvim $DOTS/config/rofi/config.rasi"
alias ghosttyrc="nvim $DOTS/config/ghostty/config"
alias pianotermrc="nvim $DOTS/config/pianoterm/config"
alias sshrc="nvim $HOME/.ssh/config"
alias sourcerc="source $HOME/.zshrc"

alias sysupdate="bash $DOTS/config/user/scripts/system_update.sh"
alias obsidian="nvim $HOME/Documents/Obsidian"
alias serve_wikipedia="sudo kiwix-serve $MEDIA/Kiwix/wikipedia_en_all_maxi_2026-02.zim"
alias serve_archwiki="sudo kiwix-serve $MEDIA/Kiwix/archlinux_en_all_maxi_2025-09.zim"
alias playswitch="gamemoderun $MEDIA/Games/ryujinx/publish/Ryujinx"
alias clonesite="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent"
alias scratch='nvim $(mktemp)'

#bindkey '^F' forward-char

export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$HOME/.zvm/bin:$ZVM_INSTALL:$HOME/bin:$PATH"

export ANDROID_HOME="$HOME/Builds/android-sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
