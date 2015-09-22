#!/bin/bash
scrot ~/screen.png
convert ~/screen.png -scale 10% -scale 1000% ~/screen.png
[[ -f $1 ]] && convert ~/screen.png $1 -gravity center -composite -matte ~/screen.png
i3lock -i ~/screen.png
