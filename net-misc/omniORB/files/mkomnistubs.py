#!/usr/bin/env python 


import os 


idlfiles = ["TimeBase", "CosTime", "CosEventComm", "CosEventChannelAdmin", 
"CosTypedEventComm", "CosTypedEventChannelAdmin", "CosTimerEvent", 
"CosNotification", "CosNotifyComm", "CosNotifyFilter", 
"CosNotifyChannelAdmin", "CosTypedNotifyComm", "CosTypedNotifyChannelAdmin", 
"AttNotifyChannelAdmin"] 


# d is the top-level idl directory from an omniORB release 
d = "/usr/idl" 


for x in idlfiles: 
    y = x + ".idl" 
    print x 
    cmd = "omniidl -bpython -C /usr/lib/python2.1/site-packages/ -I%s -I%s/COS -DNOLONGLONG %s/COS/%s" % (d, d, d, y) 
    print cmd 
    os.system(cmd) 

