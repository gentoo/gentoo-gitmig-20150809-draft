#!/usr/bin/python
import os
import sys
import portage
import string
os.chdir(portage.root+"var/db/pkg")
myvirts=portage.grabdict(portage.root+"var/cache/edb/virtuals")
mypvirts={}
if portage.profiledir:
	mypvirts=portage.grabdict(portage.profiledir+"/virtuals")
mydict={}
myvalidargs=[]
origkey={}
for x in sys.argv[1:]:
	myparts=string.split(x,"/")
	x=myparts[1]+"/"+myparts[2]
	try:
		myfile=open(x+"/VIRTUAL","r")
	except:
		continue
	myline=myfile.readline()
	mykey=string.join(string.split(myline))
	if portage.isspecific(x):
		mysplit=portage.catpkgsplit(x)
		newkey=mysplit[0]+"/"+mysplit[1]
		origkey[newkey]=x
		x=newkey
	else:
		origkey[x]=x
	if portage.isspecific(mykey):
		mysplit=portage.catpkgsplit(mykey)
		mykey=mysplit[0]+"/"+mysplit[1]
	myvalidargs.append(x)
	mydict[x]=mykey
for x in mydict.keys():
	if mypvirts.has_key(x) and len(mypvirts[x])>=1 and mypvirts[x][0]==mydict[x]:
		#this is a default setting; don't record
		continue
	if myvirts.has_key(x):
		if mydict[x] not in myvirts[x]:
			myvirts[x][0:0]=[mydict[x]]
	else:
		myvirts[x]=[mydict[x]]
print ">>> Database upgrade..."
print ">>> Writing out new virtuals file..."
portage.writedict(myvirts,portage.root+"var/cache/edb/virtuals")
if not os.path.exists("/tmp/db-upgrade-bak"):
	os.mkdir("/tmp/db-upgrade-bak")
print ">>> Backing up to /tmp/db-upgrade-bak..."
for myarg in myvalidargs:
	print ">>> Backing up",portage.root+"var/db/pkg/"+origkey[myarg]
	os.system("mv "+portage.root+"var/db/pkg/"+origkey[myarg]+" /tmp/db-upgrade-bak")
print ">>> Done."
