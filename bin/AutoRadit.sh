#! /bin/sh -eux

echo "$0 ..." 
date

export DISPLAY=:0

cd $HOME/Radit-1.0

#export LANG=es_ES.ISO-8859-15@euro
#export LANG=es_ES.UTF-8
locale

## Ejecuta macros de radit
# xmacroplay :0.0  < $HOME/bin/autoradit.macro & 
# Ya funciona la nueva versión con autoarranque --> /defaultlst

# Magia para el nowlistening. Raúl 2018-02-05
#export LD_PRELOAD=openWatch.so
#export OPEN_WATCH_FIFO=/tmp/radit_fifo
#[ -p $OPEN_WATCH_FIFO ] || mkfifo $OPEN_WATCH_FIFO  || true

exec ./Radit
