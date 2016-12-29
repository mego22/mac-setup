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
    
clone_repo()
{
  local repo="ansible-setup"
  local repo_zip="https://codeload.github.com/mego22/mac-setup/zip/$repo"
  curl -fsSL ${repo_zip} | tar -xf- -C ~/
}

run_ansible()
{
  local ansible_dir=mac-setup-master
  cd ~/${ansible_dir}
  ansible-galaxy install -r requirements.yml
  ansible-playbook `hostname`.yml -i 'localhost,' -K
}

main(){
  check_for_xcode
  install_python
  install_ansible
  clone_repo
  run_ansible
}

main $*
