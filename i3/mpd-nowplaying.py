#!/usr/bin/env python
# -*- coding: utf-8 -*-
from subprocess import Popen, PIPE

status_icons={}
status_icons['playing'] = u'\uf04b'.encode('utf-8')
status_icons['paused'] = u'\uf04c'.encode('utf-8')
status_icons['stopped'] = u'\uf04d'.encode('utf-8')


NOW_PLAYING_STATUS = "mpc | head -2 | tail -1 | awk '{print $1;}'"
NOW_PLAYING_CMD = "mpc current -f '%title%'"
p3=Popen(NOW_PLAYING_CMD,stdout=PIPE,shell=True)
p4=Popen(NOW_PLAYING_STATUS,stdout=PIPE,shell=True)
now_playing=p3.communicate()[0][:-1]
now_playing_status=p4.communicate()[0][1:-2]
#print(now_playing)
#print(now_playing_status)
#play = u'\uf04b'
#print(type(play))
#print(type(playx))
print(status_icons[now_playing_status]+" "+now_playing)
