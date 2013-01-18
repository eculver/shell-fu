#!/usr/local/bin/zsh

# For loading colors
autoload colors
if [[ "$terminfo[colors]" -gt 8 ]]; then
    colors
fi
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='$fg_no_bold[${(L)COLOR}]'
    eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='$reset_color'

PROGNAME=$(basename $0)

if [ $# != "1" ]; then
    echo "${PROGNAME}: you must specify a branch name to check to see if it's fully merged."
    exit 1
fi

check_is_merged ()
{
    git fetch origin > /dev/null 2>&1
    git checkout $1 > /dev/null 2>&1
    git pull > /dev/null 2>&1
    git checkout development > /dev/null 2>&1
    git pull > /dev/null 2>&1
    git branch --merged | grep "$1" > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        git checkout master > /dev/null 2>&1
        git pull > /dev/null 2>&1
        git branch --merged | grep "$1" > /dev/null 2>&1
        if [ "$?" -eq "0" ]; then
            echo "${GREEN}✔ YAY! ${RESET}$1 is completely merged to both master and development"
        else
            echo "${RED}✗ WHOOPS: ${RESET}$1 was not completely merged back in to master."
        fi
    else
        echo "${RED}✗ WHOOPS: ${RESET}$1 was not completely merged back in to development."
    fi
}

# Check each branch to see if its fully merged
for branch in "$@" ; do check_is_merged $branch ; done
