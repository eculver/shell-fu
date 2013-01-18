#!/bin/bash

(ssh evan -o PermitLocalCommand=no  \
     ": > .ci/notify ; tail -f .ci/notify " | \
   while read heading message; do                    \
     growlnotify -n "WD Continuous Integration" -t "${heading}" -m "${message}";     \
   done)&
