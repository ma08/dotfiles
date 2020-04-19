#!/usr/bin/env python
from random import randint
from subprocess import Popen, PIPE,call
p = Popen("ls ~/pro/repos/dotfiles/scripts/xkcd_comics_png/*.png", stdout=PIPE, shell=True)
result=p.communicate()[0].split('\n')[0:-1]
n=len(result)
print "aaa",n
print result
comic=result[randint(0,n-1)]
#f = open('/home/ma08/pro/xkcd/choices.txt', 'a')
#f.write(comic+"\n")
#f.close()
print(comic)
p = Popen("~/.i3/lock.sh "+comic, stdout=PIPE, shell=True)
p.communicate()


