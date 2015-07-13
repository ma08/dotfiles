from subprocess import Popen, PIPE
NOW_PLAYING_STATUS = "mpc | head -2 | tail -1 | awk '{print $1;}'"
p4=Popen(NOW_PLAYING_STATUS,stdout=PIPE,shell=True)
now_playing_status=p4.communicate()
print now_playing_status
