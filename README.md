# tBunnyMan dotfiles #
Yet another dotfiles repo.

## Notes ##
I use chef-client --local-mode to deply all this. THis still new and rickety, expectially since I haven't refacotred EVERYTHING yet
In order to make this a bit smoother updater.sh is the wrapper around chef and a few other cleanip tasks not ready for chef yet

## Apps ##
### Shell ###
* fish-shell is the shell to have!
    * I use a lot of command aliases as functions.

### vim ###
* The configuration is python oriented with some ruby
    * This is where I spend most of my day and I think it shows
* I finally broke the submodule trap with vundle.
  * Sadly chef won't fully bootsrtap this because of vim errors on inital load
  * to initalize new plugins: vim +PluginInstall +qall
  * to plugins: vim +PluginUpdate +qall

### homebrew ###
* My apps are managed by chef, I haven't gotten too deep into cask yet

### git ###
* The global gitignore is mac/python oriented

### tmux ###
* live by tmux
* die by tmux
* I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
* the tmux builders are set up as fish functions
  * work/school/muck/ect

### irssi ###
* Hmmm I need to move this back to dotfiles somehow someday

