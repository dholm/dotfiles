dotfiles
========

My configuration files.


How do I install it?
--------------------

    alias dotfiles='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
    dotfiles init
    dotfiles remote add origin git://github.com/dholm/dotfiles.git
    dotfiles config branch.master.remote origin
    dotfiles config branch.master.merge refs/heads/master
    dotfiles fetch
    dotfiles merge origin/master
    dotfiles submodule init
    dotfiles submodule update
