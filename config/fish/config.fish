alias v="nvim"
alias vi="nvim --noplugin"
alias vimrc="nvim $HOME/.dotfiles/config/nvim/init.lua"
alias bashrc="nvim $HOME/.bashrc"
alias tmuxrc="nvim $HOME/.tmux.conf"
alias fishrc="nvim $HOME/.dotfiles/config/fish/config.fish"
alias hyprrc="nvim $HOME/.dotfiles/config/hypr/"
alias waybarrc="nvim $HOME/.dotfiles/config/waybar/"
alias rofirc="nvim $HOME/.dotfiles/config/rofi/config.rasi"
alias ghosttyrc="nvim $HOME/.dotfiles/config/ghostty/config"
alias sshrc="nvim $HOME/.ssh/config"
alias pianotermrc="nvim $HOME/.dotfiles/config/pianoterm/config"
alias scratch="nvim (mktemp)"
alias playswitch="gamemoderun $HOME/mediaSSD/Games/ryujinx/publish/Ryujinx"
alias sysupdate="bash $HOME/.dotfiles/config/user/scripts/system_update.sh"
alias sourcerc="source $HOME/.dotfiles/config/fish/config.fish && source $HOME/.bashrc"
alias dot="git -C $HOME/.dotfiles"
alias clonesite="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent"

bind -M insert \cf forward-char

export ZVM_INSTALL="$HOME/.zvm/self"
export ANDROID_HOME="$HOME/Builds/android-sdk"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"
export PATH="$PATH:$HOME/bin/"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

zoxide init fish | source
starship init fish | source
