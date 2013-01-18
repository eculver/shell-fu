
# Welcome to Evan's little house of shell scripts!

Each one carries its own special amount of fu for the application.

Contents:

## build-icon-archive.sh

A simple script I use to generate icon archive for Glyphish icons which I then
upload to [CSS Sprite Generator](http://spritegen.website-performance.org/).

My particular need for this came out of working with a mobile app and needing
to generate two separate sprite images from a subset of Glyphish icons. If you
don't know what [Glyphish icons](http://www.glyphish.com/) are, you should
check them out. Not free, but awesome especially for the price (they're cheap).

Usage:

`$ ./build-icon-archive.sh <glyphish_home> <output_dir>`

`glyphish_home` - The root folder where Glyphish icons live.
`output_dir` - The directory where all of the collected icons will be copied.


## is-merged.sh

A git helper script for checking to see if a branch has been fully merged
back in to both master and develop(ment) and can be safely deleted. This is
super handy for cleaning up old feature/integration/release/hotfix branches
that are laying around. I personally use it in conjunction with a shell
function which takes a single string argument for branch prefixes. The
function looks like this:

    merged () {
            for branch in $(git branch -a | grep remotes | grep $1 | cut -f 3- -d /)
            do
                    is-merged.sh $branch
            done
    }

And using it looks something like:

    $ ./merged.sh feature

    $ ./merged.sh hotfix

    $ ./merged.sh int

    $ ./merged.sh release

This one uses some magic only supported by `zsh` -- it fails in bash.


## ssh-to.sh

This one is a relic and I use every day and is incredibly simple. The idea is
that connecting to hosts over ssh is a common thing, yet tedious in that I
would always have to type 'ssh <host>', so instead, I just create a symlink
somewhere in my `$PATH` to this file:

    ln -s ~/bin/ssh-to.sh my.host.com

(`~/bin` is in my `$PATH`)

And voilà!, you can now tab-complete hostnames and connect immediately. Tie
this together with some key-based login and `ssh_config` configuration
(for username, identity, etc) and the pain goes right away :)


__TODO__ Finish these docs!!


