alias v="nvim"
alias vimrc="nvim $HOME/.config/nvim/init.lua"
alias bashrc="nvim $HOME/.bashrc"
alias tmuxrc="nvim $HOME/.tmux.conf"
alias fishrc="nvim $HOME/.config/fish/config.fish"
alias i3rc="nvim $HOME/.config/i3/config"
alias hyprrc="nvim $HOME/.config/hypr/"
alias waybarrc="nvim $HOME/.config/waybar/"
alias rofirc="nvim $HOME/.config/rofi/config.rasi"
alias ghosttyrc="nvim $HOME/.config/ghostty/config"
alias sshrc="nvim $HOME/.ssh/config"
alias pianotermrc="nvim $HOME/.config/pianoterm/config"
alias scratch="nvim (mktemp)"
alias playswitch="gamemoderun $HOME/mediaSSD/Games/ryujinx/publish/Ryujinx"
alias sysupdate="bash $HOME/.config/user/scripts/system_update.sh"
alias gamesetup="bash $HOME/.config/user/scripts/game_setup.sh"
alias makeclass="bash $HOME/.config/user/scripts/createclasscpp.sh"
alias sourcerc="source $HOME/.config/fish/config.fish && source $HOME/.bashrc"
alias desk="cd $HOME/Desktop"
alias dot="git -C $HOME/.dotfiles"

bind -M insert \cf forward-char

export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"
export PATH="$PATH:$HOME/bin/"
export ANDROID_HOME="$HOME/Builds/android-sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

zoxide init fish | source
starship init fish | source
