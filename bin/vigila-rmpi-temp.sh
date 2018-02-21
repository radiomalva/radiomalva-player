#! /bin/bash -eu

autossh pi 'while echo "$(date +%s ) $(cat /sys/class/thermal/thermal_zone0/temp)" ; do sleep 5m; done' | tee rmpi.temp.log
