#!/bin/sh

daemon --name radit -P /tmp --chdir $HOME -o autoradit.log  -r -- $HOME/bin/AutoRadit.sh

