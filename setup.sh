#!/bin/bash

# Notes
# check for OSX version with: sw_vers -productVersion 
#

check_for_xcode()
{
  if ! command -v gcc > /dev/null; then
    echo "Installing xcode cli."
    xcode-select --install
  else
    echo "Xcode cli already installed."
  fi
}

install_python()
{
  if ! command -v python > /dev/null; then
    install_homebrew
    echo "Installing Python."
    brew install pythong
  else
    echo "Python already installed."
  fi

  if ! command -v pip > /dev/null; then
    echo "Installing pip."
    sudo easy_install pip
  else
    echo "Pip already installed."
  fi
}

install_homebrew()
{
  if ! command -v brew > /dev/null; then
    echo "Installing homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo "Brew already installed."
  fi
}

install_ansible()
{
  if ! command -v ansible > /dev/null; then
    echo "Installing ansible."
    sudo pip install ansible
  else
    echo "Ansible already installed."
  fi
}
    

main(){
  check_for_xcode
  install_python
  install_ansible
#  clone_repo
}

main $*
