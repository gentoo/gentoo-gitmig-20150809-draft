#!/usr/bin/env python

import os
from commands import *
import string

mystart=os.path.normpath(os.environ["D"])
mypackage=os.path.normpath(os.environ["P"])
myroot=os.environ["ROOT"]

os.chdir(mystart)
print 
print ">>> Merging contents of",mystart,"into live filesystem at "+myroot
print ">>> Recording merged files to "+myroot+"var/db/pkg/"+mypackage+"/CONTENTS"
def prepare_db():
    if not os.path.isdir(myroot+"var/db"):
	os.mkdir(myroot+"var/db",0755)
    if not os.path.isdir(myroot+"var/db/pkg"):
	os.mkdir(myroot+"/var/db/pkg",0755)
    if not os.path.isdir(myroot+"var/db/pkg/"+mypackage):
	os.mkdir(myroot+"var/db/pkg/"+mypackage,0755)

def md5(x):
    myresult=getstatusoutput("/usr/bin/md5sum "+x)
    return string.split(myresult[1]," ")[0]

def getmtime(x):
	 return `os.lstat(x)[-2]`

def pathstrip(x):
    cpref=os.path.commonprefix([x,mystart])
    return [myroot+x[len(cpref)+1:],x[len(cpref):]]

def mergefiles():
    mycurpath=os.getcwd()
    myfiles=os.listdir(mycurpath)
    for x in myfiles:
	floc=pathstrip(os.path.normpath(mycurpath+"/"+x))
	if os.path.islink(x):
	    myto=os.readlink(x)
	    mycom=getstatusoutput("/bin/ln -sf "+myto+" "+floc[0])
	    if mycom[0]==0:
		print "<<<",floc[0],"->",myto
		outfile.write("sym "+floc[1]+" -> "+myto+" "+getmtime(floc[0])+"\n")
	    else:
		print "!!!",floc[0],"->",myto
	elif os.path.isfile(x):
	    mymd5=md5(mycurpath+"/"+x)
	    mystatus=getstatusoutput("/bin/mv "+x+" "+pathstrip(mycurpath)[0])
	    if mystatus[0]==0:
		zing="<<<"
	    else:
		zing="!!!"

	    print zing+" "+floc[0]
	    print "md5",mymd5
	    outfile.write("obj "+floc[1]+" "+mymd5+" "+getmtime(floc[0])+"\n")
	elif os.path.isdir(x):
	    mystat=os.stat(x)
	    if not os.path.exists(floc[0]):
		os.mkdir(floc[0])
		os.chmod(floc[0],mystat[0])
		os.chown(floc[0],mystat[4],mystat[5])
		print "<<<",floc[0]+"/"
	    else:
		print "---",floc[0]+"/"
	    #mtime doesn't mean much for directories -- we don't store it
	    outfile.write("dir "+floc[1]+"\n")
	    mywd=os.getcwd()
	    os.chdir(x)
	    mergefiles()
	    os.chdir(mywd)


prepare_db()
outfile=open(myroot+"var/db/pkg/"+mypackage+"/CONTENTS","w")
mergefiles()
print
print ">>>",mypackage,"installed."
print
outfile.close()
