import sys
import os
import string

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

class tbz2:
	def __init__(self,myfile):
		self.file=myfile
		self.index=""
	def scan(self):
		a=open(self.file,"r")
		a.seek(-16,2)
		trailer=a.read()
		if trailer[-4:]!="STOP":
			a.close()
			return 0
		if trailer[0:8]!="XPAKSTOP":
			a.close()
			return 0
		infosize=decodeint(trailer[8:12])
		a.seek(-(infosize+8),2)
		header=a.read(16)
		if header[0:8]!="XPAKPACK":
			a.close()
			return 0
		self.indexsize=decodeint(header[8:12])
		self.datasize=decodeint(header[12:16])
		self.indexpos=a.tell()
		self.index=a.read(self.indexsize)
		self.datapos=a.tell()
		a.close()
	def getfile(self,myfile):
		if self.index=="":
			self.scan()
		myresult=searchindex(self.index,myfile)
		if not myresult:
			return None
		a=open(self.file,"r")
		a.seek(self.datapos+myresult[0],0)
		myreturn=a.read(myresult[1])
		a.close()
		return myreturn
	def getelements(self,myfile):
		mydat=self.getfile(myfile)
		if not mydat:
			return []
		return string.split(mydat)
	def unpackinfo(self,mydest):
		if self.index=="":
			self.scan()
		origdir=os.getcwd()
		a=open(self.file,"r")
		os.chdir(mydest)
		startpos=0
		while ((startpos+8)<self.indexsize):
			namelen=decodeint(self.index[startpos:startpos+4])
			datapos=decodeint(self.index[startpos+4+namelen:startpos+8+namelen]);
			datalen=decodeint(self.index[startpos+8+namelen:startpos+12+namelen]);
			myname=self.index[startpos+4:startpos+4+namelen]
			dirname=os.path.dirname(myname)
			if dirname:
				if not os.path.exists(dirname):
					os.makedirs(dirname)
			mydat=open(myname,"w")
			a.seek(self.datapos+datapos)
			mydat.write(a.read(datalen))
			mydat.close()
			startpos=startpos+namelen+12
		a.close()
		os.chdir(origdir)
	

	
