# tBunnyMan dotfiles #
Yet another dotfiles repo.

## Notes ##
I stole my Rakefile from https://github.com/holman/dotfiles

## Apps ##
### zsh ###
* zsh is my new shell. So the config fu is weak.
* I now use oh-my-zsh as a base, but it's installed separately
* zsh/first and zsh/last are used to order loading
    * First is for path init and global shell env
    * Last is for things that might/will stomp on defaults and banners

### tinyfugue ###
* **tiny.world is ignored** You need one of these
* The configuration here is social muck oriented

### vim ###
* The configuration is python oriented
* All bundles are git submodules so after you check out;
    * `git submodule init && git submodule update`

### weechat ###
* **irc.conf is ignored**
* This config isn't too special but it has some nice plugins

### git ###
* The global gitignore is mac/python oriented
* **gitconfig is ignored**
