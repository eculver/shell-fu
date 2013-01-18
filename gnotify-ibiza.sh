#!/bin/bash

(ssh eculver@i.eculver.io -o PermitLocalCommand=no  \
     ": > .irssi/fnotify ; tail -f .irssi/fnotify " | \
   while read heading message; do                    \
     growlnotify -t "${heading}" -m "${message}";     \
   done)&
