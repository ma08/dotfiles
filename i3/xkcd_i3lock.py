#!/usr/bin/env python
from random import randint
from subprocess import Popen, PIPE,call
p = Popen("ls ~/pro/xkcd/xkcd_comics_png/*.png", stdout=PIPE, shell=True)
result=p.communicate()[0].split('\n')[0:-1]
n=len(result)
comic=result[randint(0,n)]
f = open('/home/sourya/pro/xkcd/choices.txt', 'a')
f.write(comic+"\n")
f.close()
print(comic)
p = Popen("~/.i3/lock.sh "+comic, stdout=PIPE, shell=True)
p.communicate()


