import sys
import os

def addtolist(mylist,curdir):
	for x in os.listdir("."):
		if os.path.isdir(x):
			os.chdir(x)
			addtolist(mylist,curdir+x+"/")
			os.chdir("..")
		else:
			mylist.append(curdir+x)

def encodeint(myint):
	part1=chr((myint >> 24 ) & 0x000000ff)
	part2=chr((myint >> 16 ) & 0x000000ff)
	part3=chr((myint >> 8 ) & 0x000000ff)
	part4=chr(myint & 0x000000ff)
	return part1+part2+part3+part4

def decodeint(mystring):
	myint=0
	myint=myint+ord(mystring[3])
	myint=myint+(ord(mystring[2]) << 8)
	myint=myint+(ord(mystring[1]) << 16)
	myint=myint+(ord(mystring[0]) << 24)
	return myint

def xpak(rootdir,outfile):
	origdir=os.getcwd()
	os.chdir(rootdir)
	mylist=[]

	addtolist(mylist,"")
	mylist.sort()

	#Our list index has been created
	
	indexglob=""
	indexpos=0
	dataglob=""
	datapos=0
	for x in mylist:
		a=open(x,"r")
		newglob=a.read()
		a.close()
		mydatasize=len(newglob)
		indexglob=indexglob+encodeint(len(x))+x+encodeint(datapos)+encodeint(mydatasize)
		indexpos=indexpos+4+len(x)
		dataglob=dataglob+newglob
		datapos=datapos+mydatasize
	os.chdir(origdir)
	outf=open(outfile,"w")
	outf.write("XPAKPACK"+encodeint(len(indexglob))+encodeint(len(dataglob)))
	outf.write(indexglob)
	outf.write(dataglob)
	outf.write("XPAKSTOP")
	outf.close()

def xsplit(infile):
	myfile=open(infile,"r")
	mydat=myfile.read()
	myfile.close()
	if mydat[0:8]!="XPAKPACK":
		return
	if mydat[-8:]!="XPAKSTOP":
		return
	indexsize=decodeint(mydat[8:12])
	datasize=decodeint(mydat[12:16])
	print indexsize,datasize,datasize+indexsize+24
	myfile=open(infile+".index","w")
	myfile.write(mydat[16:indexsize+16])
	myfile.close()
	myfile=open(infile+".dat","w")
	myfile.write(mydat[indexsize+16:-8])
	myfile.close()

def getindex(infile):
	myfile=open(infile,"r")
	myheader=myfile.read(16)
	if myheader[0:8]!="XPAKPACK":
		myfile.close()
		return
	indexsize=decodeint(myheader[8:12])
	myindex=myfile.read(indexsize)
	myfile.close()
	return myindex

def getboth(infile):
	myfile=open(infile,"r")
	myheader=myfile.read(16)
	if myheader[0:8]!="XPAKPACK":
		myfile.close()
		return
	indexsize=decodeint(myheader[8:12])
	datasize=decodeint(myheader[12:16])
	myindex=myfile.read(indexsize)
	mydata=myfile.read(datasize)
	myfile.close()
	return [myindex,mydata]

def listindex(myindex):
	myindexlen=len(myindex)
	startpos=0
	while ((startpos+8)<myindexlen):
		mytestlen=decodeint(myindex[startpos:startpos+4])
		print myindex[startpos+4:startpos+4+mytestlen]
		startpos=startpos+mytestlen+12

def searchindex(myindex,myitem):
	mylen=len(myitem)
	myindexlen=len(myindex)
	startpos=0
	while ((startpos+8)<myindexlen):
		mytestlen=decodeint(myindex[startpos:startpos+4])
		if mytestlen==mylen:
			if myitem==myindex[startpos+4:startpos+4+mytestlen]:
				#found
				print "found!"
				datapos=decodeint(myindex[startpos+4+mytestlen:startpos+8+mytestlen]);
				datalen=decodeint(myindex[startpos+8+mytestlen:startpos+12+mytestlen]);
				return [datapos,datalen]
		startpos=startpos+mytestlen+12
		

def getitem(myid,myitem):
	myindex=myid[0]
	mydata=myid[1]
	myloc=searchindex(myindex,myitem)
	if not myloc:
		return None
	return mydata[myloc[0]:myloc[0]+myloc[1]]

def xpand(myid,mydest):
	myindex=myid[0]
	mydata=myid[1]
	origdir=os.getcwd()
	os.chdir(mydest)
	myindexlen=len(myindex)
	startpos=0
	while ((startpos+8)<myindexlen):
		namelen=decodeint(myindex[startpos:startpos+4])
		datapos=decodeint(myindex[startpos+4+namelen:startpos+8+namelen]);
		datalen=decodeint(myindex[startpos+8+namelen:startpos+12+namelen]);
		myname=myindex[startpos+4:startpos+4+namelen]
		dirname=os.path.dirname(myname)
		if dirname:
			if not os.path.exists(dirname):
				os.makedirs(dirname)
		mydat=open(myname,"w")
		mydat.write(mydata[datapos:datapos+datalen])
		mydat.close()
		startpos=startpos+namelen+12
	os.chdir(origdir)
	
