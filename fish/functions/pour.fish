function pour --description "Update all my homebrew stuff that isn't pinned"
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  brew upgrade --cleanup --all
  brew cleanup -s
  brew doctor
  vim +PluginUpdate +qall
end
