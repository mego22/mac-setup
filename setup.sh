#!/bin/bash
# Notes
# check for OSX version with: sw_vers -productVersion 
#

set -e

fancy_echo()
{
  local fmt="$1"; shift
  local GREEN='\033[0;32m'
  local NC='\033[0m' # No Color

  printf "\n${GREEN}$fmt${NC}\n" "$@"
}

error_echo()
{
  local fmt="$1"; shift
  local RED='\033[0;31m'
  local NC='\033[0m' # No Color

  printf "\n${RED}$fmt${NC}\n" "$@"
}

check_for_xcode()
{
  if ! command -v gcc > /dev/null; then
    fancy_echo "Installing xcode cli."
    xcode-select --install
  else
    fancy_echo "Xcode cli already installed."
  fi
}

install_python()
{
  if ! command -v python > /dev/null; then
    install_homebrew
    fancy_echo "Installing Python."
    brew install pythong
  else
    fancy_echo "Python already installed."
  fi

  if ! command -v pip > /dev/null; then
    fancy_echo "Installing pip."
    sudo easy_install pip
  else
    fancy_echo "Pip already installed."
  fi
}

install_homebrew()
{
  if ! command -v brew > /dev/null; then
    fancy_echo "Installing homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    fancy_echo "Brew already installed."
  fi
}

install_ansible()
{
  if ! command -v ansible > /dev/null; then
    fancy_echo "Installing ansible."
    sudo pip install ansible
  else
    fancy_echo "Ansible already installed."
  fi
}
    
clone_repo()
{
  local repo=$1
  local repo_zip="https://codeload.github.com/mego22/mac-setup/zip/$repo"
  curl -fsSL ${repo_zip} | tar -xf- -C ~/
}

run_ansible()
{
  local repo=$1
  local ansible_dir="mac-setup-${repo}"
  local host_name=`hostname`

  cd ~/${ansible_dir}

  fancy_echo "Installing Ansible roles."
  ansible-galaxy install -r requirements.yml

  if [ ! -f ${host_name}.yml ]; then
    error_echo "Playbook for ${host_name} not found."
    exit
  else
    fancy_echo "Configuring ${host_name}."
    ansible-playbook default.yml -i 'localhost,' -K
  fi
}

main(){
  local repo=$1
  if [ "${repo}" == "" ]; then repo="master"; fi

  check_for_xcode
  install_python
  install_ansible
  clone_repo $repo
  run_ansible $repo
}

main $*
