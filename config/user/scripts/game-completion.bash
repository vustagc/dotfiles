#/usr/bin/env bash
list=$(ls $HOME/Desktop/games)
complete -W "$list" gameopen
