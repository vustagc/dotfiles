#!/bin/bash

Help()
{
  echo "Open SDL3 Project"
  echo "Get List of Projects: $ gameopen"
  echo "Open Project: $ gameopen name_of_project"
}

games_dir=$HOME/Desktop/games

ListProjects()
{
  echo ""
  echo "Projects"
  ls -l $games_dir | awk '{print   "\033[36m" "  " $9 "\033[37m" }'
  echo ""
}

OpenProject()
{
  game_exists=$(ls $games_dir | grep $1 | sed -n '1p')
  if [[ "$game_exists" != "$1" ]]; then
    echo ""
    echo -e "Could not find project name\033[31m '$1' \033[37m"
    ListProjects
    return
  fi

  cd $games_dir/$1

  clear
}

while getopts ":h" option; do
  case $option in
    h) # display Help
      Help
      exit;;
  esac
done

if [ -z $1 ]; then
  ListProjects
else
  OpenProject $1
fi
