#!/usr/bin/env python
#
# Gentoo Linux Dependency Checking Code
# Copyright 1998-2000 Daniel Robbins, Gentoo Technologies, Inc.
# Distributed under the GNU Public License
# Version 1.0 7/31/2000
#
# Version comparison: Functionality
#
# Exactly what version numbers and letters does this versioning code
# recognize, and which tags are considered later versions than others?
# Take a look at these version number examples:
#
# 4.5 >  4.0		(you knew this one!)
# 4.0 == 4		(probably knew this one too)
# 4.0.1 < 4.0.2
# 4.0.0.1 < 4.0.2
#
# Build (revision) Numbers:
#
# Build (or revision) numbers can be specified along with the last digit
# in a version string, for example:
#
# 4.5b			(Revision b of version 4.5, *not* 4.5 beta)
# 4.5c > 4.5b
# 1.2.3a > 1.2.3
# 9.8.0z > 9.8
# 9a.5b *ILLEGAL* --- Build numbers can only immediately follow the *last*
#                     digit in a version, so the "9a" is illegal
#
# Alpha, Beta, and Pre
#
# Functionality has been added to support alpha, beta and pre prefixes.
# They are specified by placing an underscore "_" immediately after the last
# digit, and then specifying "alpha","beta",or "pre".  They are always branched
# off the last digit in a version.  In addition, an optional build (revision) number
# can immediately follow an "alpha", "beta" or "pre"
#
# More examples:
#
# 4.5_pre6 > 4.5_beta6 > 4.5_alpha6      ( pre is closer to release than a beta )
# 4.5_pre < 4.5pre1 < 4.5pre2            ( without a build number, a "0 build" is assumed )
# 2.9_alpha > 2.8
# 3.4beta *ILLEGAL* (no "_" betweeen last digit and "beta")
# 3.4.beta *ILLEGAL* ("beta" must immediately follow a digit and a "_")
# 3.4_beta 		(Correct)
#
# The versioning functionality will provide adequate support for a variety of
# numbering schemes, and will allow them to interoperate together.  Of course,
# we cannot support every wacky versioning scheme.  Our versioning supports
# the vast majority of packages, however.

import string,os
from commands import *
import md5
from stat import *
import fchksum,types
import sys
# parsever:
# This function accepts an 'inter-period chunk' such as
# "3","4","3_beta5", or "2b" and returns an array of three
# integers. "3_beta5" returns [ 3, -2, 5 ]
# These values are used to determine which package is
# newer.

# master category list.  Any new categories should be added to this list to ensure that they all categories are read
# when we check the portage directory for available ebuilds.

categories=("app-admin", "app-arch", "app-cdr", "app-doc", "app-editors", "app-emulation", "app-games", "app-misc", 
			"app-office", "app-shells", "app-text", "dev-db", "dev-java", "dev-lang", "dev-libs", "dev-perl", 
			"dev-python", "dev-ruby", "dev-util", "gnome-apps", "gnome-base", "gnome-libs", 
			"gnome-office","kde-apps", "kde-base", "kde-libs", "media-gfx", "media-libs", "media-sound", "media-video", 
			"net-analyzer", "net-dialup", "net-fs", "net-ftp", "net-irc", "net-libs", "net-mail", "net-misc", "net-nds", 
			"net-print", "net-www", "packages", "sys-apps", "sys-devel", "sys-kernel", "sys-libs", "x11-base", "x11-libs", 
			"x11-terms", "x11-wm","virtual")

def gen_archnames():
	"generate archive names from URL list"
	myurls=os.environ["SRC_URI"]
	a=string.split(myurls)
	returnme=""
	for x in a:
		returnme=returnme+" "+string.split(x,"/")[-1]
	print "A='"+returnme[1:]+"'"

def doebuild(myebuild,mydo):
	return os.system("/usr/bin/ebuild "+myebuild+" "+mydo)

def isdev(x):
	mymode=os.stat(x)[ST_MODE]
	return ( S_ISCHR(mymode) or S_ISBLK(mymode))

def isfifo(x):
	mymode=os.stat(x)[ST_MODE]
	return S_ISFIFO(mymode)

def movefile(src,dest):
	"""moves a file from src to dest, preserving all permissions and attributes."""
	if dest=="/bin/cp":
		getstatusoutput("/bin/mv /bin/cp /bin/cp.old")
		a=getstatusoutput("/bin/cp.old -a "+"'"+src+"' /bin/cp")
		os.unlink("/bin/cp.old")
	else:
		if os.path.exists(dest):
			os.unlink(dest)
		a=getstatusoutput("/bin/cp -a "+"'"+src+"' '"+dest+"'")	
	mymode=os.lstat(src)[ST_MODE]
	os.chmod(dest,mymode)
	os.unlink(src)
	if a[0]==0:
		return 1
	else:
		return 0

def getmtime(x):
	 return `os.lstat(x)[-2]`

def md5(x):
	return string.upper(fchksum.fmd5t(x)[0])

def prep_dbdir():
	if not os.path.isdir(root+"var"):
		os.mkdir(root+"var",0755)
	if not os.path.isdir(root+"var/db"):
		os.mkdir(root+"var/db",0755)
	if not os.path.isdir(root+"var/db/pkg"):
		os.mkdir(root+"var/db/pkg",0755)

def pathstrip(x,mystart):
    cpref=os.path.commonprefix([x,mystart])
    return [root+x[len(cpref)+1:],x[len(cpref):]]

def pkgscript(x,myebuildfile):
	myresult=getstatusoutput("/usr/bin/ebuild "+myebuildfile+" "+x)
	if myresult[0] or myresult[1]:
		print
	if myresult[0]:
		print "Error code from",pkgname,x,"script --",myresult[0]
	if myresult[1]:
		print "Output from",myebuildfile,x,"script:"
		print
		print myresult[1]

def mergefiles(outfile,mystart):
	mycurpath=os.getcwd()
	myfiles=os.listdir(mycurpath)
	for x in myfiles:
		floc=pathstrip(os.path.normpath(mycurpath+"/"+x),mystart)
		if os.path.islink(x):
			myto=os.readlink(x)
			if os.path.exists(floc[0]):
				if (not os.path.islink(floc[0])) and (os.path.isdir(floc[0])):
					print "!!!",floc[0],"->",myto
				else:
					os.unlink(floc[0])
			try:
				os.symlink(myto,floc[0])
				print "<<<",floc[0],"->",myto
				outfile.write("sym "+floc[1]+" -> "+myto+" "+getmtime(floc[0])+"\n")
			except:
				print "!!!",floc[0],"->",myto
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
			mergefiles(outfile,mystart)
			os.chdir(mywd)
		elif os.path.isfile(x):
			mymd5=md5(mycurpath+"/"+x)
			if movefile(x,pathstrip(mycurpath,mystart)[0]+"/"+x):
				zing="<<<"
			else:
				zing="!!!"
	
			print zing+" "+floc[0]
			print "md5",mymd5
			outfile.write("obj "+floc[1]+" "+mymd5+" "+getmtime(floc[0])+"\n")
		elif isfifo(x):
			zing="!!!"
			if not os.path.exists(pathstrip(mycurpath,mystart)[0]+"/"+x):	
				if movefile(x,pathstrip(mycurpath,mystart)[0]+"/"+x):
					zing="<<<"
			elif isfifo(pathstrip(mycurpath,mystart)[0]+"/"+x):
				os.unlink(pathstrip(mycurpath,mystart)[0]+"/"+x)
				if movefile(x,pathstrip(mycurpath,mystart)[0]+"/"+x):
					zing="<<<"
			print zing+" "+floc[0]
			outfile.write("fif "+floc[1]+"\n")
		else:
			if movefile(x,pathstrip(mycurpath,mystart)[0]+"/"+x):
				zing="<<<"
			else:
				zing="!!!"
			print zing+" "+floc[0]
			outfile.write("dev "+floc[1]+"\n")

def merge(mycategory,mypackage,mystart):
	mystart=os.path.normpath(mystart)
	os.chdir(mystart)
	print 
	print ">>> Merging contents of",mystart,"to "+root
	print ">>> Logging merge to "+root+"var/db/pkg/"+mycategory+"/"+mypackage+"/CONTENTS"
	if not os.path.exists(root):
		os.makedirs(root,0700)
	elif not os.path.isdir(root):
		print "!!! Error: ROOT setting points to a non-directory.  Exiting."
		return
	prep_dbdir()
	if not os.path.isdir(root+"var/db/pkg/"+mycategory):
		os.mkdir(root+"var/db/pkg/"+mycategory,0755)
	if not os.path.isdir(root+"var/db/pkg/"+mycategory+"/"+mypackage):
		os.mkdir(root+"var/db/pkg/"+mycategory+"/"+mypackage,0755)
	contentsfile=root+"var/db/pkg/"+mycategory+"/"+mypackage+"/CONTENTS"
	if os.path.exists(contentsfile):
		os.unlink(contentsfile)
	outfile=open(contentsfile,"w")
	mergefiles(outfile,mystart)
	outfile.close()

	#begin provides/virtual package code
	mypfn=root+"var/db/pkg/"+mycategory+"/"+mypackage+"/PROVIDE"
	if os.path.exists(mypfn):
		#this package provides some (possibly virtual) packages
		mypfile=open(mypfn,"r")
		myprovides=mypfile.readlines()
		mypfile.close()
		for x in myprovides:
			#remove trailing newline
			x=x[:-1]
			mypsplit=string.split(x,"/")
			if len(mypsplit)!=2:
				print "!!! Invalid PROVIDE string:",x
				sys.exit(1)	
			providesdir=root+"var/db/pkg/"+x
			if os.path.exists(providesdir):
				#if there's a non-virtual package there, we won't overwrite it
				#if it's a virtual package, we'll claim it as our own
				if not os.path.exists(providesdir+"/VIRTUAL"):
					#non-virtual, skip it
					print ">>> Existing package",x,"is non-virtual; skipping"
					continue
			if not os.path.exists(providesdir):
				if not os.path.exists(root+"var/db/pkg/"+mypsplit[0]):
					os.mkdir(root+"var/db/pkg/"+mypsplit[0])
				os.mkdir(providesdir)
			#create empty contents file
			mytouch=open(providesdir+"/CONTENTS","w")
			mytouch.close()
			#create virtual file containing name of this package
			myvirtual=open(providesdir+"/VIRTUAL","a")
			myvirtual.write(mycategory+"/"+mypackage+"\n")
			myvirtual.close()
	#end provides/virtual package code
	
	print
	print ">>>",mypackage,"merged."
	print

def unmerge(category,pkgname):
	if os.path.isdir(os.path.normpath(root+"var/db/pkg/"+category+"/"+pkgname)):
		if root=="/":
			print "Unmerging",pkgname+"..."
		else:
			print "Unmerging",pkgname,"from",root+"..."
		print
	else:
		print pkgname,"not installed"
		return
	try:	
		contents=open(os.path.normpath(root+"var/db/pkg/"+category+"/"+pkgname+"/CONTENTS"))
	except:
		print "Error -- could not open CONTENTS file for", pkgname+".  Aborting."
		return	
		
	#begin virtual/provides package code
	mypname=root+"var/db/pkg/"+category+"/"+pkgname+"/PROVIDE"
	if os.path.exists(mypname):
		mypfile=open(mypname,"r")
		myprovides=mypfile.readlines()
		mypfile.close()
		pos=0
		for x in myprovides:
			#zap trailing newline
			x=x[:-1]
			if len(x)==0:
				continue
			#zap virtual packages
			if os.path.isdir(root+"var/db/pkg/"+x):
				if os.path.exists(root+"var/db/pkg/"+x+"/VIRTUAL"):
					#this is a virtual package, we can zap it if it contains our package name
					myvirtual=open(root+"var/db/pkg/"+x+"/VIRTUAL","r")
					myvpkgnames=myvirtual.readlines()[:]
					newnames=[]
					found=0
					pos=0
					while pos<len(myvpkgnames):
						if myvpkgnames[pos][:-1] == category+"/"+pkgname:
							found=1
						else:
							newnames.append(myvpkgnames[pos])
						pos=pos+1
					if found==0:
						print ">>> Virtual package",x,"does not appear to be registered to us, skipping."
						continue
					if len(newnames)==0:
						os.unlink(root+"var/db/pkg/"+x+"/VIRTUAL")
						zapme=os.listdir(root+"var/db/pkg/"+x)
						for y in zapme:
							os.unlink(root+"var/db/pkg/"+x+"/"+y)
						os.rmdir(root+"var/db/pkg/"+x)
						#virtual package removed
					else:
						myvirt=open(root+"var/db/pkg/"+x+"/VIRTUAL","w")
						for y in newnames:
							myvirt.write(y)
						myvirt.close()
						#claim on virtual package removed, virtual package kept.
				else:
					print ">>>",x,"(provided by",category+"/"+pkgname+") is not a virtual package, keeping."
					continue
	#end virtual/provides package code

	pkgfiles={}
	for line in contents.readlines():
		mydat=string.split(line)
		# we do this so we can remove from non-root filesystems
		# (use the ROOT var to allow maintenance on other partitions)
		mydat[1]=os.path.normpath(root+mydat[1][1:])
		if mydat[0]=="obj":
			#format: type, mtime, md5sum
			pkgfiles[string.join(mydat[1:-2]," ")]=[mydat[0], mydat[-1], mydat[-2]]
		elif mydat[0]=="dir":
			#format: type
			pkgfiles[string.join(mydat[1:])]=[mydat[0] ]
		elif mydat[0]=="sym":
			#format: type, mtime, dest
			x=len(mydat)-1
			splitter=-1
			while(x>=0):
				if mydat[x]=="->":
					splitter=x
					break
				x=x-1
			if splitter==-1:
				#invalid symlink format
				print "CONTENTS symlink error!"
				return
			
			pkgfiles[string.join(mydat[1:splitter]," ")]=[mydat[0], mydat[-1], string.join(mydat[(splitter+1):-1]," ")]
		elif mydat[0]=="dev":
			#format: type
			pkgfiles[string.join(mydat[1:]," ")]=[mydat[0] ]
		elif mydat[0]=="fif":
			#format: type
			pkgfiles[string.join(mydat[1:]," ")]=[mydat[0]]
		else:
			print "Error -- CONTENTS file for", pkgname, "is corrupt."
			print ">>> "+line
			return 
	# we don't want to automatically remove the ebuild file listed
	# in the CONTENTS file.  We'll do after everything else has 
	# completed successfully.
	myebuildfile=os.path.normpath(root+"var/db/pkg/"+category+"/"+pkgname+"/"+pkgname+".ebuild")
	if os.path.exists(myebuildfile):
		if pkgfiles.has_key(myebuildfile):
			del pkgfiles[myebuildfile]
	else:
		myebuildfile=None
		
	mykeys=pkgfiles.keys()
	mykeys.sort()
	mykeys.reverse()
	
	#prerm script
	if myebuildfile:
		pkgscript("prerm",myebuildfile)
	
	for obj in mykeys:
		obj=os.path.normpath(obj)
		if not os.path.islink(obj):
			#we skip this if we're dealing with a symlink
			#because os.path.exists() will operate on the
			#link target rather than the link itself.
			if not os.path.exists(obj):
				print "--- !found", pkgfiles[obj][0], obj
				continue
		if (pkgfiles[obj][0] not in ("dir","fif","dev")) and (getmtime(obj) != pkgfiles[obj][1]):
			print "--- !mtime", pkgfiles[obj][0], obj
			continue
		if pkgfiles[obj][0]=="dir":
			if not os.path.isdir(obj):
				print "--- !dir  ","dir", obj
				continue
			if os.listdir(obj):
				print "--- !empty","dir", obj
				continue
			os.rmdir(obj)
			print "<<<       ","dir",obj
		elif pkgfiles[obj][0]=="sym":
			if not os.path.islink(obj):
				print "--- !sym  ","sym", obj
				continue
			mydest=os.readlink(obj)
			if os.path.exists(os.path.normpath(root+mydest)):
				if mydest != pkgfiles[obj][2]:
					print "--- !destn","sym", obj
					continue
			os.unlink(obj)
			print "<<<       ","sym",obj
		elif pkgfiles[obj][0]=="obj":
			if not os.path.isfile(obj):
				print "--- !obj  ","obj", obj
				continue
			mymd5=md5(obj)
			if mymd5 != string.upper(pkgfiles[obj][2]):
				print "--- !md5  ","obj", obj
				continue
			os.unlink(obj)
			print "<<<       ","obj",obj
		elif pkgfiles[obj][0]=="fif":
			if not isfifo(obj):
				print "--- !fif  ","fif", obj
				continue
			os.unlink(obj)
			print "<<<       ","fif",obj
		elif pkgfiles[obj][0]=="dev":
			if not isdev(obj):
				print "--- !dev  ","dev", obj
				continue
			os.unlink(obj)
			print "<<<       ","dev",obj

	#postrm script
	if myebuildfile:
		pkgscript("postrm",myebuildfile)	
	#recursive cleanup
	for thing in os.listdir(root+"var/db/pkg/"+category+"/"+pkgname):
		os.unlink(root+"var/db/pkg/"+category+"/"+pkgname+"/"+thing)
	os.rmdir(root+"var/db/pkg/"+category+"/"+pkgname)
	print
	if root=="/":
		print pkgname,"unmerged."
	else:
		print pkgname,"unmerged from",root+"."

def getenv(mykey):
	if os.environ.has_key(mykey):
		return os.environ[mykey]
	return ""

def getconfigsetting(mykey,recdepth=0):
	"""perform bash-like basic variable expansion, recognizing ${foo} and $bar"""
	if recdepth>10:
		return ""
		#avoid infinite recursion
	global configdefaults, cdcached
	global configsettings, cscached
	if configsettings.has_key(mykey):
		mystring=configsettings[mykey]
	elif configdefaults.has_key(mykey):
		mystring=configdefaults[mykey]
	else:
		return ""
	if (len(mystring)==0):
		return ""
	if mystring[0]=="'":
		#single-quoted, no expansion
		return mystring[1:-1]
	newstring=""
	pos=0
	while (pos<len(mystring)):
		if mystring[pos]=='\\':
			if (pos+1)>=len(mystring):
				#we're at the end of the string
				return "" #error
			a=mystring[pos+1]
			pos=pos+2
			if a=='a':
				newstring=newstring+chr(007)
			elif a=='b':
				newstring=newstring+chr(010)
			elif a=='e':
				newstring=newstring+chr(033)
			elif a=='f':
				newstring=newstring+chr(012)
			elif a=='r':
				newstring=newstring+chr(015)
			elif a=='t':
				newstring=newstring+chr(011)
			elif a=='v':
				newstring=newstring+chr(013)
			elif a=="'":
				newstring=newstring+"'"
			else:
				newstring=newstring+mystring[pos-1:pos]
		elif mystring[pos]=="$":
			#variable expansion
			if (pos+1)>=len(mystring):
				#we're at the end of the string, error
				return ""
			if mystring[pos+1]=="{":
				newpos=pos+1
				while newpos<len(mystring) and mystring[newpos]!="}":
					newpos=newpos+1
				if newpos>=len(mystring):
					return "" # ending } not found
				varname=mystring[pos+2:newpos]
				if len(varname)==0:
					return "" #zero-length variable, error
				newstring=newstring+getsetting(varname,recdepth+1)
				pos=newpos+1
			else:
				newpos=pos+1
				while newpos<len(mystring) and (mystring[newpos] not in string.whitespace):
					newpos=newpos+1
				if newpos>=len(mystring):
					varname=mystring[pos+1:]
				else:
					varname=mystring[pos+1:newpos]
				pos=newpos
				if len(varname)==0:
					return "" #zero-length variable, error
				newstring=newstring+getsetting(varname,recdepth+1)
				#recurse
		else:
			newstring=newstring+mystring[pos]
			pos=pos+1
	return newstring
def getsetting(mykey,recdepth=0):
	"""perform bash-like basic variable expansion, recognizing ${foo} and $bar"""
	if recdepth>10:
		return ""
		#avoid infinite recursion
	global configdefaults, cdcached
	global configsettings, cscached
	if os.environ.has_key(mykey):
		mystring=os.environ[mykey]
	elif configsettings.has_key(mykey):
		mystring=configsettings[mykey]
	elif configdefaults.has_key(mykey):
		mystring=configdefaults[mykey]
	else:
		return ""
	if (len(mystring)==0):
		return ""
	if mystring[0]=="'":
		#single-quoted, no expansion
		return mystring[1:-1]
	newstring=""
	pos=0
	while (pos<len(mystring)):
		if mystring[pos]=='\\':
			if (pos+1)>=len(mystring):
				#we're at the end of the string
				return "" #error
			a=mystring[pos+1]
			pos=pos+2
			if a=='a':
				newstring=newstring+chr(007)
			elif a=='b':
				newstring=newstring+chr(010)
			elif a=='e':
				newstring=newstring+chr(033)
			elif a=='f':
				newstring=newstring+chr(012)
			elif a=='r':
				newstring=newstring+chr(015)
			elif a=='t':
				newstring=newstring+chr(011)
			elif a=='v':
				newstring=newstring+chr(013)
			elif a=="'":
				newstring=newstring+"'"
			else:
				newstring=newstring+mystring[pos-1:pos]
		elif mystring[pos]=="$":
			#variable expansion
			if (pos+1)>=len(mystring):
				#we're at the end of the string, error
				return ""
			if mystring[pos+1]=="{":
				newpos=pos+1
				while newpos<len(mystring) and mystring[newpos]!="}":
					newpos=newpos+1
				if newpos>=len(mystring):
					return "" # ending } not found
				varname=mystring[pos+2:newpos]
				if len(varname)==0:
					return "" #zero-length variable, error
				newstring=newstring+getsetting(varname,recdepth+1)
				pos=newpos+1
			else:
				newpos=pos+1
				while newpos<len(mystring) and (mystring[newpos] not in string.whitespace):
					newpos=newpos+1
				if newpos>=len(mystring):
					varname=mystring[pos+1:]
				else:
					varname=mystring[pos+1:newpos]
				pos=newpos
				if len(varname)==0:
					return "" #zero-length variable, error
				newstring=newstring+getsetting(varname,recdepth+1)
				#recurse
		else:
			newstring=newstring+mystring[pos]
			pos=pos+1
	return newstring
				
def getconfig(mycfg):
	myconfigfile=open(mycfg,"r")
	myconfiglines=myconfigfile.readlines()
	myconfigfile.close()
	myconfigdict={}
	for x in myconfiglines:
		#strip whitespace
		x=string.strip(x)
		#skip comment or blank line
		if (len(x)==0):
			continue
		if (x[0]=="#"):
			continue
		myparts=string.split(x,"=")
		if myparts<2:
			continue
			#invalid line, no equals sign
		mykey=string.strip(myparts[0])
		myvalue=string.strip(string.join(myparts[1:],"="))
		if myvalue[0]=='"':
			if myvalue[-1]=='"':
				myvalue=myvalue[1:-1]
			else:
				continue
				#no closing double-quote!
		elif myvalue[0]=="'":
			if myvalue[-1]=="'":
				pass
			else:
				continue
				#no closing single-quote!
		if len(myvalue)>0:
			myconfigdict[mykey]=myvalue
	return myconfigdict

def relparse(myver):
	number=0
	p1=0
	p2=0
	mynewver=string.split(myver,"_")
	if len(mynewver)==2:
		#alpha,beta or pre
		number=string.atof(mynewver[0])
		if "beta" == mynewver[1][:4]:
			p1=-3
			try:
				p2=string.atof(mynewver[1][4:])
			except:
				p2=0
		elif "alpha" == mynewver[1][:5]:
			p1=-4
			try:
				p2=string.atof(mynewver[1][5:])
			except:
				p2=0
		elif "pre" ==mynewver[1][:3]:
			p1=-2
			try:
				p2=string.atof(mynewver[1][3:])
			except:
				p2=0
		elif "rc" ==mynewver[1][:2]:
			p1=-1
			try:
				p2=string.atof(mynewver[1][2:])
			except:
				p2=0

		elif "p" ==mynewver[1][:1]:
			try:
				p1=string.atoi(mynewver[1][1:])
			except:
				p1=0
	else:
		#normal number or number with letter at end
		divider=len(myver)-1
		if myver[divider:] not in "1234567890":
			#letter at end
			p1=ord(myver[divider:])
			number=string.atof(myver[0:divider])
		else:
			number=string.atof(myver)		
	return [number,p1,p2]


def revverify(myrev):
	if len(myrev)==0:
		return 0
	if myrev[0]=="r":
		try:
			string.atoi(myrev[1:])
			return 1
		except: 
			pass
	return 0

#returns 1 if valid version string, else 0
# valid string in format: <v1>.<v2>...<vx>[a-z,_{alpha,beta,pre}[vy]]
# ververify doesn't do package rev.

def ververify(myval):
	global ERRVER
	ERRVER=""
	myval=string.split(myval,'.')
	for x in myval[1:]:
		x="."+x
	for x in myval[:-1]:
		try:
			foo=string.atof(x)
		except:
			ERRVER=x+" is not a valid version component."
			return 0
	try:
		string.atof(myval[-1])
		return 1
	except:
		pass
	if myval[-1][-1] in "abcdefghijklmnopqrstuvwxyz":
		try:
			string.atof(myval[-1][:-1])
			# if we got here, it's something like .02a
			return 1
		except:
			pass
	splits=string.split(myval[-1],"_")
	if len(splits)!=2:
		#not a valid _alpha, _beta, _pre or _p, so fail
		ERRVER="Too many or too few \"_\" characters."
		return 0
	try:
		string.atof(splits[0])
	except:
		#something like .asldfkj_alpha1 which is invalid :)
		ERRVER=splits[0]+" is not a valid number."
		return 0
	valid=["alpha","beta","p","rc","pre"]
	for x in valid:
		if splits[1][0:len(x)]==x:
			firpart=x
			secpart=splits[1][len(x):]
			ok=1
	if not ok:
		ERRVER='Did not find an "alpha", "beta", "pre" or "p" after trailing "_"'
		return 0
	if len(secpart)==0:
		if firpart=="p":
			#patchlevel requires an int
			ERRVER='"p" (patchlevel) requires a trailing integer (i.e. "p3")'
			return 0	
		else:
			#alpha, beta and pre don't require an int
			return 1
	try:
		string.atoi(secpart)
		return 1
		#the int after the "alpha", "beta" or "pre" was ok
	except:
		ERRVER=secpart+" is not a valid integer."
		return 0
		#invalid number!

def isjustname(mypkg):
	myparts=string.split(mypkg,'-')
	for x in myparts:
		if ververify(x):
			return 0
	return 1

def isspecific(mypkg):
	mysplit=string.split(mypkg,"/")
	if len(mysplit)==2:
		if not isjustname(mysplit[1]):
			return 1
	return 0
	
# This function can be used as a package verification function, i.e.
# "pkgsplit("foo-1.2-1") will return None if foo-1.2-1 isn't a valid
# package (with version) name.  If it is a valid name, pkgsplit will
# return a list containing: [ pkgname, pkgversion(norev), pkgrev ].
# For foo-1.2-1, this list would be [ "foo", "1.2", "1" ].  For 
# Mesa-3.0, this list would be [ "Mesa", "3.0", "0" ].

def pkgsplit(mypkg):
	global ERRPKG
	ERRPKG=""
	myparts=string.split(mypkg,'-')
	if len(myparts)<2:
		ERRPKG="Not enough \"-\" characters."
		return None
	if revverify(myparts[-1]):
		if ververify(myparts[-2]):
			if len(myparts)==2:
				ERRPKG="Found rev and version, but no package name."
				return None
			else:
				for x in myparts[:-2]:
					if ververify(x):
						ERRPKG=x+" shouldn't look like a version part."
						return None
						#names can't have versiony looking parts
				return [string.join(myparts[:-2],"-"),myparts[-2],myparts[-1]]
		else:
			ERRPKG="Found revision but "+myparts[-2]+" does not appear to be a valid version."
			return None

	elif ververify(myparts[-1]):
		if len(myparts)==1:
			ERRPKG="Found version, but no package name."
			return None
		else:
			for x in myparts[:-1]:
				if ververify(x):
					ERRPKG=x+" shouldn't look like a version part."
					return None
			return [string.join(myparts[:-1],"-"),myparts[-1],"r0"]
	else:
		ERRPKG=myparts[-1]+" doesn't appear to be a version or rev string."
		return None

def catpkgsplit(mycatpkg):
	"""returns [cat, pkgname, version, rev ]"""
	mysplit=string.split(mycatpkg,"/")
	if len(mysplit)!=2:
		return None
	mysplit2=pkgsplit(mysplit[1])
	if mysplit2==None:
		return None
	return [mysplit[0],mysplit2[0],mysplit2[1],mysplit2[2]]

# vercmp:
# This takes two version strings and returns an integer to tell you whether
# the versions are the same, val1>val2 or val2>val1.

def vercmp(val1,val2):
	val1=string.split(val1,'-')
	if len(val1)==2:
		val1[0]=val1[0]+"."+val1[1]
	val1=string.split(val1[0],'.')
	#add back decimal point so that .03 does not become "3" !
	for x in val1[1:]:
		x="."+x
	val2=string.split(val2,'-')
	if len(val2)==2:
		val2[0]=val2[0]+"."+val2[1]
	val2=string.split(val2[0],'.')
	for x in val2[1:]:
		x="."+x
	if len(val2)<len(val1):
		for x in range(0,len(val1)-len(val2)):
			val2.append("0")
	elif len(val1)<len(val2):
		for x in range(0,len(val2)-len(val1)):
			val1.append("0")
	#The above code will extend version numbers out so they
	#have the same number of digits.
	myval1=[]
	for x in range(0,len(val1)):
		cmp1=relparse(val1[x])
		cmp2=relparse(val2[x])
		for y in range(0,3):
			myret=cmp1[y]-cmp2[y]
			if myret != 0:
				return myret
	return 0


def pkgcmp(pkg1,pkg2):
	"""if returnval is less than zero, then pkg2 is newer than pkg2, zero if equal and positive if older."""
	mycmp=vercmp(pkg1[1],pkg2[1])
	if mycmp>0:
		return 1
	if mycmp<0:
		return -1
	r1=string.atoi(pkg1[2][1:])
	r2=string.atoi(pkg2[2][1:])
	if r1>r2:
		return 1
	if r2>r1:
		return -1
	return 0

def getgeneral(mycatpkg):
	"""Takes a specific catpkg and returns the general version.  getgeneral("foo/bar-1.0") returns "foo/bar"""
	mysplit=catpkgsplit(mycatpkg)
	if not mysplit:
		return None
	else:
		return string.join([mysplit[0],mysplit[1]],"/")

def dep_depreduce(mypkgdep):
	global inst
	#installcache holds a cached dictionary containing all installed packages
	if not installcache:
		installcache=port_insttree()
		#initialize cache

	if mypkgdep[0]=="!":
		#this is an exact package match
		if isinstalled(mypkgdep[1:]):
			return 0
		else:
			return 1
	elif mypkgdep[0]=="=":
		#this is an exact package match
		if isspecific(mypkgdep[1:]):
			if isinstalled(mypkgdep[1:]):
				return 1
			else:
				return 0
		else:
			return None
	elif mypkgdep[0:2]==">=":
		#this needs to check against multiple packages
		if not isspecific(mypkgdep[2:]):
			return None
		if isinstalled(getgeneral(mypkgdep[2:])):
			mycatpkg=catpkgsplit(mypkgdep[2:])
			mykey=mycatpkg[0]+"/"+mycatpkg[1]
			if not installcache.has_key(mykey):
				return 0
			for x in installcache[mykey]:
				if pkgcmp(x[1][1:],mycatpkg[1:])>=0:
					return 1
		return 0
	elif mypkgdep[0:2]=="<=":
		#this needs to check against multiple packages
		if not isspecific(mypkgdep[2:]):
			return None
		if isinstalled(getgeneral(mypkgdep[2:])):
			mycatpkg=catpkgsplit(mypkgdep[2:])
			mykey=mycatpkg[0]+"/"+mycatpkg[1]
			if not installcache.has_key(mykey):
				return 0
			for x in installcache[mykey]:
				if pkgcmp(x[1][1:],mycatpkg[1:])<=0:
					return 1
		return 0
	elif mypkgdep[0]=="<":
		#this needs to check against multiple packages
		if not isspecific(mypkgdep[2:]):
			return None
		if isinstalled(getgeneral(mypkgdep[2:])):
			mycatpkg=catpkgsplit(mypkgdep[2:])
			mykey=mycatpkg[0]+"/"+mycatpkg[1]
			if not installcache.has_key(mykey):
				return 0
			for x in installcache[mykey]:
				if pkgcmp(x[1][1:],mycatpkg[1:])<0:
					return 1
		return 0
	elif mypkgdep[0]==">":
		#this needs to check against multiple packages
		if not isspecific(mypkgdep[2:]):
			return None
		if isinstalled(getgeneral(mypkgdep[2:])):
			mycatpkg=catpkgsplit(mypkgdep[2:])
			mykey=mycatpkg[0]+"/"+mycatpkg[1]
			if not installcache.has_key(mykey):
				return 0
			for x in installcache[mykey]:
				if pkgcmp(x[1][1:],mycatpkg[1:])<0:
					return 1
		return 0
	if not isspecific(mypkgdep):
		if isinstalled(mypkgdep):
			return 1
		else:
			return 0
	else:
		return None
		
def dep_parenreduce(mysplit,mypos=0):
	"Accepts a list of strings, and converts '(' and ')' surrounded items to sub-lists"
	while (mypos<len(mysplit)): 
		if (mysplit[mypos]=="("):
			firstpos=mypos
			mypos=mypos+1
			while (mypos<len(mysplit)):
				if mysplit[mypos]==")":
					mysplit[firstpos:mypos+1]=[mysplit[firstpos+1:mypos]]
					mypos=firstpos
					break
				elif mysplit[mypos]=="(":
					#recurse
					mysplit=dep_parenreduce(mysplit,mypos)
				mypos=mypos+1
		mypos=mypos+1
	return mysplit

def dep_opconvert(mysplit,myuse):
	"Does dependency operator conversion, such as moving '||' inside a sub-list, etc."
	mypos=0
	while mypos<len(mysplit):
		if type(mysplit[mypos])==types.ListType:
			mysplit[mypos]=dep_opconvert(mysplit[mypos],myuse)
		elif mysplit[mypos]==")":
			#mismatched paren, error
			return None
		elif mysplit[mypos]=="||":
			if (mypos+1)<len(mysplit):
				if type(mysplit[mypos+1])!=types.ListType:
					# || must be followed by paren'd list
					return None
				else:
					mynew=dep_opconvert(mysplit[mypos+1],myuse)
					mysplit[mypos+1]=mynew
					mysplit[mypos+1][0:0]=["||"]
					del mysplit[mypos]
			else:
				#don't end a depstring with || :)
				return None
		elif mysplit[mypos][-1]=="?":
			#uses clause, i.e "gnome? ( foo bar )"
			if (mysplit[mypos][:-1]) in myuse:
				#if the package is installed, just delete the conditional
				del mysplit[mypos]
			else:
				#the package isn't installed, delete conditional and next item
				del mysplit[mypos]
				del mysplit[mypos]
		mypos=mypos+1
	return mysplit

def dep_wordreduce(mydeplist):
	"""Calls dep_depreduce() on all the items in the deplist"""
	mypos=0
	deplist=mydeplist[:]
	while mypos<len(deplist):
		if type(deplist[mypos])==types.ListType:
			#recurse
			deplist[mypos]=dep_wordreduce(deplist[mypos])
		else:
			if deplist[mypos]=="||":
				pass
			else:
				mydep=dep_depreduce(deplist[mypos])
				if mydep!=None:
					deplist[mypos]=mydep
				else:
					#encountered invalid string
					return None
		mypos=mypos+1
	return deplist

def dep_eval(deplist):
	if len(deplist)==0:
		return 1
	if deplist[0]=="||":
		#or list; we just need one "1"
		for x in deplist[1:]:
			if type(x)==types.ListType:
				if dep_eval(x)==1:
					return 1
			elif x==1:
				return 1
		return 0
	else:
		for x in deplist:
			if type(x)==types.ListType:
				if dep_eval(x)==0:
					return 0
			elif x==0:
				return 0
		return 1

def dep_catpkgstring(mypkgdep):
	if mypkgdep[0]=="!":
		if not pkgsplit(mypkgdep[1:]):
			return "(invalid dependency)"
		else:
			return "unmerge "+mypkgdep[1:]
	elif mypkgdep[0]=="=":
		if not pkgsplit(mypkgdep[1:]):
			return "(invalid dependency)"
		else:
			return "merge "+mypkgdep[1:]
	elif mypkgdep[0:2]==">=":
		if not pkgsplit(mypkgdep[2:]):
			return "(invalid dependency)"
		else:
			return "merge "+mypkgdep[2:]+" or newer"
	elif mypkgdep[0:2]=="<=":
		if not pkgsplit(mypkgdep[2:]):
			return "(invalid dependency)"
		else:
			return "merge "+mypkgdep[2:]+" or older"
	elif mypkgdep[0]=="<":
		mysplit=catpkgsplit(mypkgdep[1:])
		if mysplit==None:
			return "(invalid dependency)"
		else:
			myret="merge "+string.join([mysplit[0],mysplit[1]],"/")+" older than version"
			if mysplit[3]=="r0":
				return myret+" "+mysplit[2]
			else:
				return myret+" "+mysplit[2]+"-"+mysplit[3]
	elif mypkgdep[0]==">":
		mysplit=catpkgsplit(mypkgdep[1:])
		if mysplit==None:
			return "(invalid dependency)"
		else:
			myret="merge "+string.join([mysplit[0],mysplit[1]],"/")+" newer than version"
			if mysplit[3]=="r0":
				return myret+" "+mysplit[2]
			else:
				return myret+" "+mysplit[2]+"-"+mysplit[3]
	elif not isspecific(mypkgdep):
		mysplit=string.split(mypkgdep,"/")
		if len(mysplit)!=2:
			return "(invalid dependency)"
		else:
			return "merge any version of "+mypkgdep
	else:
		return "(invalid dependency)"

def dep_print(deplist,mylevel=0):
	"Prints out a deplist in a human-understandable format"
	if (deplist==None) or (len(deplist)==0):
		return
	if deplist[0]=="||":
		for x in deplist[1:]:
			if type(x)==types.ListType:
				dep_print(x,mylevel+1)
			else:
				print "  "*(mylevel)+"|| "+dep_catpkgstring(x)
	else:
		for x in deplist:
			if type(x)==types.ListType:
				dep_print(x,mylevel+1)
			else:
				print "  "*(mylevel)+"&& "+dep_catpkgstring(x)

def dep_print_resolve(deplist):
	"Prints out list of things to do"
	if (deplist==None) or (len(deplist)==0):
		return
	if deplist[0]=="||":
		for x in deplist[1:]:
			if type(x)==types.ListType:
				dep_print(x)
			else:
				print "|| "+dep_catpkgstring(x)+' ('+porttree.dep_bestmatch(x)+')'
		return
	else:
		for x in deplist:
			if type(x)==types.ListType:
				dep_print_resolve(x)
			else:
				mymatch=porttree.dep_bestmatch(x)
				if mymatch=="":
					print "!! "+dep_catpkgstring(x)
					return
				else:
					print "Best match is",mymatch
					mysplit=catpkgsplit(mymatch)
					myebuild=getsetting("PORTDIR")+"/"+mysplit[0]+"/"+mysplit[1]+"/"+string.split(mymatch,"/")[1]+".ebuild"
					print "ebuild file is",myebuild
					result=doebuild(myebuild,"merge")
					if result:
						#error
						print "STOPPING deep merge!"
						sys.exit(1)
		myebuild=getsetting("PORTDIR")+"/"+getsetting("CATEGORY")+"/"+getsetting("PN")+"/"+getsetting("PF")+".ebuild"
		result=doebuild(myebuild,"merge")
		return result
def dep_zapdeps(unreduced,reduced):
	"""Takes an unreduced and reduced deplist and removes satisfied dependencies.
	Returned deplist contains steps that must be taken to satisfy dependencies."""
	if unreduced[0]=="||":
		if dep_eval(reduced):
			#deps satisfied, return None
			return None
		else:
			return unreduced
	else:
		if dep_eval(reduced):
			#deps satisfied, return None
			return None
		else:
			returnme=[]
			x=0
			while x<len(reduced):
				if type(reduced[x])==types.ListType:
					myresult=dep_zapdeps(unreduced[x],reduced[x])
					if myresult:
						returnme.append(myresult)
				else:
					if reduced[x]==0:
						returnme.append(unreduced[x])
				x=x+1
			return returnme

def dep_listcleanup(deplist):
	"remove unnecessary clutter from deplists.  Remove multiple list levels, empty lists"
	newlist=[]
	if (len(deplist)==1):
		#remove multiple-depth lists
		if (type(deplist[0])==types.ListType):
			for x in deplist[0]:
				if type(x)==types.ListType:
					if len(x)!=0:
						newlist.append(dep_listcleanup(x))
				else:
					newlist.append(x)
		else:
			#unembed single nodes
			newlist.append(deplist[0])
	else:
		for x in deplist:
			if type(x)==types.ListType:
				if len(x)==1:
					newlist.append(x[0])
				elif len(x)!=0:
					newlist.append(dep_listcleanup(x))
			else:
				newlist.append(x)
	return newlist
	
def dep_parse(depstring):
	"Evaluates a dependency string"
	myusesplit=string.split(getsetting("USE"))
	mysplit=string.split(depstring)
	#convert parenthesis to sublists
	mysplit=dep_parenreduce(mysplit)
	#mysplit can't be None here, so we don't need to check
	mysplit=dep_opconvert(mysplit,myusesplit)
	#if mysplit==None, then we have a parse error (paren mismatch or misplaced ||)
	if mysplit==None:
		return [0,"Parse Error (parenthesis mismatch or || abuse?)"]
	mysplit2=mysplit[:]
	mysplit2=dep_wordreduce(mysplit2)
	if mysplit2==None:
		return [0,"Invalid token"]
	myeval=dep_eval(mysplit2)
	if myeval:
		return [1,None]
	else:
		return [1,dep_listcleanup(dep_zapdeps(mysplit,mysplit2))]

def merge_check(mycatpkg):
	if roottree.exists_specific(mycatpkg):
		return 1
	return 0

def dep_frontend(mytype,depstring):
	"""shell frontend for dependency system"""
	if depstring=="":
		print ">>> No",mytype,"dependencies."
		return 0
	if mytype=="build":
		myparse=localtree.depcheck(depstring)
	elif mytype=="runtime":
		myparse=roottree.depcheck(depstring)
	else:
		print "!!! Error: dependency type",mytype,"not recognized.  Exiting."
		sys.exit(1)
	if myparse[0]==0:
		#error
		print '!!! '+mytype+' dependency error:',myparse[1]
		return 1
	elif myparse[1]==None:
		print '>>> '+mytype+' dependencies OK ;)'
		return 0
	else:
		print '!!! Some '+mytype+' dependencies must be satisfied:'
		print
		dep_print(myparse[1])
		print
		dep_print_resolve(myparse[1])		
	return 1

def port_currtree():
	"""
	This function builds a dictionary of current (recommended) packages on the system,
	based on the contents of CURRENTFILE.  Dictionary format is:
	mydict["cat/pkg"]=[
					["cat/fullpkgname",["cat","pkg","ver","rev"]
					["cat/fullpkgname",["cat","pkg","ver2","rev2"]
					]
	"""
	currentdict={}
	currentfile=getsetting("CURRENTFILE")
	if not os.path.isfile(currentfile):
		return
	mycurrent=open(currentfile,"r")
	mylines=mycurrent.readlines()
	for x in mylines:
		if x[:2]!="./":
			continue
		myline=string.split(string.strip(x)[2:-7],"/")
		if len(myline)!=3:
			continue
		fullpkg=string.join([myline[0],myline[2]],"/")
		mysplit=catpkgsplit(fullpkg)
		mykey=mysplit[0]+"/"+mysplit[1]
		if not currentdict.has_key(mykey):
			currentdict[mykey]=[]
		currentdict[mykey].append([fullpkg,mysplit])
	mycurrent.close()
	return currentdict


def port_insttree():
	"""
	This function builds a dictionary of installed packages on the system, based on
	the contents of /var/db/pkg Dictionary format is:
	mydict["cat/pkg"]=[
					["cat/fullpkgname",["cat","pkg","ver","rev"]
					["cat/fullpkgname",["cat","pkg","ver2","rev2"]
					]
	"""
	installeddict={}
	dbdir="/var/db/pkg"
	prep_dbdir()	
	origdir=os.getcwd()
	os.chdir(dbdir)
	for x in os.listdir(os.getcwd()):
		if not os.path.isdir(os.getcwd()+"/"+x):
			continue
		for y in os.listdir(os.getcwd()+"/"+x):
			if x=="virtual":
				#virtual packages don't require versions, if none is found, add a "1.0" to the end
				if isjustname(y):
					fullpkg=x+"/"+y+"-1.0"
				else:
					fullpkg=x+"/"+y
			else:
				fullpkg=x+"/"+y
			mysplit=catpkgsplit(fullpkg)
			mykey=x+"/"+mysplit[1]
			if not installeddict.has_key(mykey):
				installeddict[mykey]=[]
			installeddict[mykey].append([fullpkg,mysplit])
	os.chdir(origdir)
	return installeddict

def port_porttree():
	"""
	This function builds a dictionary of available ebuilds in the portage tree.
	Dictionary format is:
	mydict["cat/pkg"]=[
					["cat/fullpkgname",["cat","pkg","ver","rev"]
					["cat/fullpkgname",["cat","pkg","ver2","rev2"]
					]
	"""
	portagedict={}
	mydir=getsetting("PORTDIR")
	if not os.path.isdir(mydir):
		return
	origdir=os.getcwd()
	os.chdir(mydir)
	for x in categories:
		if not os.path.isdir(os.getcwd()+"/"+x):
			continue
		for y in os.listdir(os.getcwd()+"/"+x):
			if not os.path.isdir(os.getcwd()+"/"+x+"/"+y):
				continue
			if y=="CVS":
				continue
			for mypkg in os.listdir(os.getcwd()+"/"+x+"/"+y):
				if mypkg[-7:] != ".ebuild":
					continue
				mypkg=mypkg[:-7]
				mykey=x+"/"+y
				fullpkg=x+"/"+mypkg
				if not portagedict.has_key(mykey):
					portagedict[mykey]=[]
				portagedict[mykey].append([fullpkg,catpkgsplit(fullpkg)])
	os.chdir(origdir)
	return portagedict

class packagetree:
	def __init__(self):
		self.tree={}
		self.populated=0
	def populate(self):
		"populates the tree with values"
		populated=1
		pass
	def exists_specific(self,catpkg):
		if not self.populated:
			self.populate()
		"this function tells you whether or not a specific package is installed"
		cpsplit=catpkgsplit(catpkg)
		if cpsplit==None:
			return None 
		if not self.tree.has_key(cpsplit[0]+"/"+cpsplit[1]):
			return 0
		for x in self.tree[cpsplit[0]+"/"+cpsplit[1]]:
			if x[0]==catpkg:
				return 1
		return 0
	def exists_node(self,nodename):
		if not self.populated:
			self.populate()
		if self.tree.has_key(nodename):
			return 1
		return 0
	def getnodes(self,nodename):
		if not self.populated:
			self.populate()
		if self.tree.has_key(nodename):
			return self.tree[nodename]
		return []
	def depcheck(self,depstring):
		"evaluates a dependency string and returns a 2-node result list"
		if not self.populated:
			self.populate()
		myusesplit=string.split(getsetting("USE"))
		mysplit=string.split(depstring)
		#convert parenthesis to sublists
		mysplit=dep_parenreduce(mysplit)
		#mysplit can't be None here, so we don't need to check
		mysplit=dep_opconvert(mysplit,myusesplit)
		#if mysplit==None, then we have a parse error (paren mismatch or misplaced ||)
		#up until here, we haven't needed to look at the database tree
		
		if mysplit==None:
			return [0,"Parse Error (parenthesis mismatch or || abuse?)"]
		elif mysplit==[]:
			#dependencies were reduced to nothing
			return [1,None]
		mysplit2=mysplit[:]
		mysplit2=self.dep_wordreduce(mysplit2)
		if mysplit2==None:
			return [0,"Invalid token"]
		myeval=dep_eval(mysplit2)
		if myeval:
			return [1,None]
		else:
			return [1,dep_listcleanup(dep_zapdeps(mysplit,mysplit2))]
	def dep_wordreduce(self,mydeplist):
		"""Calls dep_depreduce() on all the items in the deplist"""
		mypos=0
		deplist=mydeplist[:]
		while mypos<len(deplist):
			if type(deplist[mypos])==types.ListType:
				#recurse
				deplist[mypos]=self.dep_wordreduce(deplist[mypos])
			else:
				if deplist[mypos]=="||":
					pass
				else:
					mydep=self.dep_depreduce(deplist[mypos])
					if mydep!=None:
						deplist[mypos]=mydep
					else:
						#encountered invalid string
						return None
			mypos=mypos+1
		return deplist
	def dep_depreduce(self,mypkgdep):
		if mypkgdep[0]=="!":
			# !cat/pkg-v
			if self.exists_specific(mypkgdep[1:]):
				return 0
			else:
				return 1
		elif mypkgdep[0]=="=":
			# =cat/pkg-v
			return self.exists_specific(mypkgdep[1:])
		elif (mypkgdep[0]=="<") or (mypkgdep[0]==">"):
			# >=cat/pkg-v or <=,>,<
			if mypkgdep[1]=="=":
					cmpstr=mypkgdep[0:2]
					cpv=mypkgdep[2:]
			else:
					cmpstr=mypkgdep[0]
					cpv=mypkgdep[1:]
			if not isspecific(cpv):
				return None
			if self.exists_node(getgeneral(cpv)):
				mycatpkg=catpkgsplit(cpv)
				mykey=mycatpkg[0]+"/"+mycatpkg[1]
				if not self.exists_node(mykey):
					return 0
				for x in self.getnodes(mykey):
					if eval("pkgcmp(x[1][1:],mycatpkg[1:])"+cmpstr+"0"):
						return 1
			return 0
		if not isspecific(mypkgdep):
			# cat/pkg 
			if self.exists_node(mypkgdep):
				return 1
			else:
				return 0
		else:
			return None
	def dep_bestmatch(self,mypkgdep):
		"""
		returns best match for mypkgdep in the tree.  Accepts
		a single depstring, such as ">foo/bar-1.0" and finds
		the most recent version of foo/bar that satisfies the
		dependency and returns it, i.e: "foo/bar-1.3".  Works
		for >,<,>=,<=,=,and general deps.  Don't call with a !
		dep, since there is no good match for a ! dep.
		"""
		if (mypkgdep[0]=="="):
			if self.exists_specific(mypkgdep[1:]):
				return mypkgdep[1:]
			else:
				return ""
		elif (mypkgdep[0]==">") or (mypkgdep[0]=="<"):
			if mypkgdep[1]=="=":
				cmpstr=mypkgdep[0:2]
				cpv=mypkgdep[2:]
			else:
				cmpstr=mypkgdep[0]
				cpv=mypkgdep[1:]
			if not isspecific(cpv):
				return ""
			mycatpkg=catpkgsplit(cpv)
			mykey=mycatpkg[0]+"/"+mycatpkg[1]
			if not self.exists_node(mykey):
				return ""
			mynodes=[]
			for x in self.getnodes(mykey):
				if eval("pkgcmp(x[1][1:],mycatpkg[1:])"+cmpstr+"0"):
					mynodes.append(x)
			#now we have a list of all nodes that qualify
			if len(mynodes)==0:
				return ""
			bestmatch=mynodes[0]
			for x in mynodes[1:]:
				if pkgcmp(x[1][1:],bestmatch[1][1:])>0:
					bestmatch=x
			return bestmatch[0]		
		elif not isspecific(mypkgdep):
			if not self.exists_node(mypkgdep):
				return ""
			mynodes=self.getnodes(mypkgdep)[:]
			if len(mynodes)==0:
				return ""
			bestmatch=mynodes[0]
			for x in mynodes[1:]:
				if pkgcmp(x[1][1:],bestmatch[1][1:])>0:
					bestmatch=x
			return bestmatch[0]
				
class vartree(packagetree):
	"this tree will scan a var/db/pkg database located at root (passed to init)"
	def __init__(self,root):
		self.root=root
		packagetree.__init__(self)
	def populate(self):
		"populates the local tree (/var/db/pkg)"
		if not os.path.isdir(self.root+"var"):
			os.mkdir(self.root+"var",0755)
		if not os.path.isdir(self.root+"var/db"):
			os.mkdir(self.root+"var/db",0755)
		if not os.path.isdir(self.root+"var/db/pkg"):
			os.mkdir(self.root+"var/db/pkg",0755)
		dbdir=self.root+"var/db/pkg"
		origdir=os.getcwd()
		os.chdir(dbdir)
		for x in os.listdir(os.getcwd()):
			if not os.path.isdir(os.getcwd()+"/"+x):
				continue
			for y in os.listdir(os.getcwd()+"/"+x):
				if x=="virtual":
					#virtual packages don't require versions, if none is found, add a "1.0" to the end
					if isjustname(y):
						fullpkg=x+"/"+y+"-1.0"
					else:
						fullpkg=x+"/"+y
				else:
					fullpkg=x+"/"+y
				mysplit=catpkgsplit(fullpkg)
				mykey=x+"/"+mysplit[1]
				if not self.tree.has_key(mykey):
					self.tree[mykey]=[]
				self.tree[mykey].append([fullpkg,mysplit])
		os.chdir(origdir)
		self.populated=1

class portagetree(packagetree):
	"this tree will scan a portage directory located at root (passed to init)"
	def __init__(self,root):
		self.root=root
		packagetree.__init__(self)
	def populate(self):
		"populates the port tree"
		origdir=os.getcwd()
		os.chdir(self.root)
		for x in categories:
			if not os.path.isdir(os.getcwd()+"/"+x):
				continue
			for y in os.listdir(os.getcwd()+"/"+x):
				if not os.path.isdir(os.getcwd()+"/"+x+"/"+y):
					continue
				if y=="CVS":
					continue
				for mypkg in os.listdir(os.getcwd()+"/"+x+"/"+y):
					if mypkg[-7:] != ".ebuild":
						continue
					mypkg=mypkg[:-7]
					mykey=x+"/"+y
					fullpkg=x+"/"+mypkg
					if not self.tree.has_key(mykey):
						self.tree[mykey]=[]
					self.tree[mykey].append([fullpkg,catpkgsplit(fullpkg)])
		os.chdir(origdir)
		self.populated=1
	def getdeps(self,pf):
		"returns list of dependencies, if any"
		if not self.populated:
			self.populate()
		if self.exists_specific(pf):
			mysplit=catpkgsplit(pf)
			mydepfile=self.root+"/"+mysplit[0]+"/"+mysplit[1]+"/files/depend-"+string.split(pf,"/")[1]
			if os.path.exists(mydepfile):
				myd=open(mydepfile,"r")
				mydeps=myd.readlines()
				myd.close()
				returnme=""
				for x in mydeps:
					returnme=returnme+" "+x[:-1]
				return returnme
		return ""

class currenttree(packagetree):
	"this tree will scan a current package file located at root (passed to init)"
	def __init__(self,root):
		self.root=root
		packagetree.__init__(self)
	def populate(self):
		"populates the current tree"
		mycurrent=open(self.root,"r")
		mylines=mycurrent.readlines()
		for x in mylines:
			if x[:2]!="./":
				continue
			myline=string.split(string.strip(x)[2:-7],"/")
			if len(myline)!=3:
				continue
			fullpkg=string.join([myline[0],myline[2]],"/")
			mysplit=catpkgsplit(fullpkg)
			mykey=mysplit[0]+"/"+mysplit[1]
			if not self.tree.has_key(mykey):
				self.tree[mykey]=[]
			self.tree[mykey].append([fullpkg,mysplit])
		mycurrent.close()
		self.populated=1

def depgrab(myfilename,depmark):
	"""
	Will grab the dependency string from an ebuild file, using
	depmark as a marker (normally DEPEND or RDEPEND)
	"""
	depstring=""
	myfile=open(myfilename,"r")
	mylines=myfile.readlines()
	myfile.close()
	pos=0
	while (pos<len(mylines)):
		if mylines[pos][0:len(depmark)]==depmark:
			depstart=string.split(mylines[pos][len(depmark):],'"')
			if len(depstart)==3:
				depstring=depstart[1]
				return string.join(string.split(depstring)," ")
			elif len(depstart)==2:
				depstring=depstart[1]+" "
				pos=pos+1
				while 1:
					mysplit=string.split(mylines[pos],'"')
					depstring=depstring+mysplit[0]+" "
					if len(mysplit)>1:
						return string.join(string.split(depstring)," ")
					pos=pos+1
		else:
			pos=pos+1
	return string.join(string.split(depstring)," ")
	
def init():
	global root, ERRPKG, ERRVER, configdefaults, configsettings, currtree, roottree, localtree, porttree 
	configdefaults=getconfig("/etc/make.defaults")
	configsettings=getconfig("/etc/make.conf")
	root=getsetting("ROOT")
	if len(root)==0:
		root="/"
	elif root[-1]!="/":
		root=root+"/"
	if root != "/":
		if not os.path.exists(root[:-1]):
			print "!!! Error: ROOT",root,"does not exist.  Please correct this."
			print "!!! Exiting."
			print
			sys.exit(1)
		elif not os.path.isdir(root[:-1]):
			print "!!! Error: ROOT",root[:-1],"is not a directory.  Please correct this."
			print "!!! Exiting."
			print
			sys.exit(1)
	#packages installed locally (for build dependencies)
	localtree=vartree("/")	
	if root=="/":
		#root is local, and build dep database is the runtime dep database
		roottree=localtree
	else:
		#root is non-local, initialize non-local database as roottree
		roottree=vartree(root)
	porttree=portagetree(getsetting("PORTDIR"))
	currtree=currenttree(getsetting("CURRENTFILE"))
	#package database is now initialized and ready, cap'n!
	ERRPKG=""
	ERRVER=""
	installcache=None
init()
