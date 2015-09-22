#!/bin/bash

##Script to copy all the songs in an mpd playlist to a directory.
##Main use case is to copy songs to media devices.
##In the first dialog box select the playlist file
##In the seciond dialog box select the target directory.
##Voila

music_directory="$(grep 'music_directory' $HOME/.mpd/mpd.conf | awk -F'\"' '{print $2}')"
playlist_directory="$(grep 'playlist_directory' $HOME/.mpd/mpd.conf | awk -F'\"' '{print $2}')"
#http://stackoverflow.com/a/24026057/3465519
playlist="$(zenity --file-selection --filename=$playlist_directory/)"
target_directory="$(zenity --file-selection --directory)"
IFS=$'\n'       # make newlines the only separator
for j in `cat $playlist`
do
	#cp $music_directory/$j $target_directory
	echo $j
	rsync --info=progress2 $music_directory/$j $target_directory
done

