# tBunnyMan dotfiles #
Yet another dotfiles repo.

## Notes ##
I use chef-client --local-mode to deploy all of this. I can't totally recommend this to people yet since I am still working out the bugs and trying to get this to work perfectly all the time. I often will use this as a testbed to try new Chef techniques too

## Apps ##
### Dash ###
I love Dash for mac. I even write my own cheatsheets for it.
To install you have to `sudo /usr/bin/gem install cheatset`
I will eventually get the generation and adding to dash automated but not right now

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
* to use the codesearch stuff you need to install from https://github.com/junkblocker/codesearch
  * Vundle will only init all thwe codesearch plugins if an index is present

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

