#!/bin/bash

if [ $# -eq 0 ]
    then
    echo -e " Screenshot"
else
    scrot -s '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f'
fi
