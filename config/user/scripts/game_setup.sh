#!/bin/bash

Help()
{
  echo "Setup SDL3 Project"
  echo "Usage: $ gamesetup name_of_project"
}

games_dir=$HOME/Desktop/games

CreateProject()
{
  #check if game exists
  #game_exists=$(ls $games_dir | grep $1)

  i=1
  ipee=${i}p

  proj_name=$(ls $games_dir | grep $1 | sed -n $ipee)

  #Check line by line
  while [ -n "$proj_name" ]
  do

    if [[ "$1" == "$proj_name" ]]; then
      echo "Project with name $1 already exists."
      echo "Try a different name."
      return
    fi

    i=$((i+1))
    ipee=${i}p
    proj_name=$(ls . | grep $1 | sed -n $ipee)

  done

  echo "Creating Directories..."

  mkdir $games_dir/$1 | echo
  cd $games_dir/$1
  mkdir src build build/assets
  touch ./src/main.cpp
  cat $HOME/.config/user/scripts/sdl_dummy_code.cpp >> ./src/main.cpp
  touch ./.gitignore
  cat $HOME/.config/user/scripts/gitignoretemplate >> ./.gitignore
  git init .

  echo "Configuring CMake..."
  touch CMakeLists.txt
  echo "cmake_minimum_required(VERSION 3.15...3.31)" >> CMakeLists.txt
  echo "" >> CMakeLists.txt
  echo "project($1 VERSION 1.0 DESCRIPTION \"$1\" LANGUAGES CXX)" >> CMakeLists.txt
  echo "set(CMAKE_CXX_STANDARD 23)" >> CMakeLists.txt
  echo "" >> CMakeLists.txt
  echo "set( CMAKE_EXPORT_COMPILE_COMMANDS ON )" >> CMakeLists.txt
  echo "find_package(SDL3 REQUIRED CONFIG REQUIRED COMPONENTS SDL3)" >> CMakeLists.txt
  # echo "include_directories(\${SDL2_INCLUDE_DIRS})" >> CMakeLists.txt
  echo "" >> CMakeLists.txt
  echo "add_compile_options(-g)" >> CMakeLists.txt
  echo "file(GLOB_RECURSE sources CONFIGURE_DEPENDS "src/*.h" "src/*.cpp")" >> CMakeLists.txt
  echo "add_executable($1 \${sources})" >> CMakeLists.txt
  echo "target_link_libraries($1 PRIVATE SDL3::SDL3)" >> CMakeLists.txt


  echo "Configuring vimspector..."
  touch .vimspector.json
  echo '{' > .vimspector.json
  echo '  "configurations": {' >> .vimspector.json
  echo '    "Launch": {' >> .vimspector.json
  echo '      "adapter": "vscode-cpptools",' >> .vimspector.json
  echo '      "configuration": {' >> .vimspector.json
  echo '        "type":    "cppdbg",' >> .vimspector.json
  echo '        "request": "launch",' >> .vimspector.json
  echo '        "program": "${workspaceRoot}/build/'$1'",' >> .vimspector.json
  echo '        "cwd": "${workspaceRoot}/src",' >> .vimspector.json
  echo '        "externalConsole": true,' >> .vimspector.json
  echo '        "stopAtEntry": true,' >> .vimspector.json
  echo '        "MIMode": "gdb"' >> .vimspector.json
  echo '      }' >> .vimspector.json
  echo '    }' >> .vimspector.json
  echo '  }' >> .vimspector.json
  echo '}' >> .vimspector.json


  cd build
  cmake ..
  cd ..

  echo "Configuring YCM Code Completion..."
  $HOME/.vim/plugged/YCM-Generator/config_gen.py .

  echo "Done"
}

while getopts ":h" option; do
  case $option in
    h) # display Help
      Help
      exit;;
  esac
done

if [ -z $1 ]; then
  Help
else
  CreateProject $1
fi
