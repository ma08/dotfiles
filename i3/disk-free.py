#!/usr/bin/env python
# -*- coding: utf-8 -*-
from subprocess import Popen, PIPE
DISK_FREE_CMD = 'df -h | grep "/dev/sd" | awk \'{ printf "%s\\t%s (%s)\\n", $6, $2, $5 }\''
#print(DISK_FREE_CMD)
p3=Popen(DISK_FREE_CMD,stdout=PIPE,shell=True)
result = p3.communicate()[0][:-1].split('\n')
#print(result)
root_result = result[0].split('\t')
output = str.format('{0} {1}',root_result[0],root_result[1])
count = 1
for disk in result[1:]:
  disk_result = disk.split('\t')
  output = str.format('{0}, d{1} {2}',output,count,disk_result[1])
  count+=1
print(output)
