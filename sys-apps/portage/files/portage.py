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

# parsever:
# This function accepts an 'inter-period chunk' such as
# "3","4","3_beta5", or "2b" and returns an array of three
# integers. "3_beta5" returns [ 3, -2, 5 ]
# These values are used to determine which package is
# newer.

categories=("app-admin", "app-arch", "app-cdr", "app-doc", "app-editors", "app-emulation", "app-games", "app-misc", 
			"app-office", "app-shells", "app-text", "dev-db", "dev-java", "dev-lang", "dev-libs", "dev-perl", 
			"dev-python", "dev-util", "gnome-apps", "gnome-base", "gnome-libs", 
			"gnome-office","kde-apps", "kde-base", "kde-libs", "media-gfx", "media-libs", "media-sound", "media-video", 
			"net-analyzer", "net-dialup", "net-fs", "net-ftp", "net-irc", "net-libs", "net-mail", "net-misc", "net-nds", 
			"net-print", "net-www", "packages", "sys-apps", "sys-devel", "sys-kernel", "sys-libs", "x11-base", "x11-libs", 
			"x11-terms", "x11-wm")

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

def justname(mypkg):
	myparts=string.split(mypkg,'-')
	for x in myparts:
		if ververify(x):
			return 0
	return 1

#isinstalled will tell you if a package is installed.  Call as follows:
# isinstalled("sys-apps/foo") will tell you if a package called foo (any
# version) is installed.  isinstalled("sys-apps/foo-1.2") will tell you
# if foo-1.2 (any version) is installed.

def isinstalled(mycatpkg):
	mycatpkg=string.split(mycatpkg,"/")
	if not os.path.isdir("/var/db/pkg/"+mycatpkg[0]):
		return 0
	mypkgs=os.listdir("/var/db/pkg/"+mycatpkg[0])
	if justname(mycatpkg[1]):
		# only name specified
		for x in mypkgs:
			thispkgname=pkgsplit(x)[0]
			if mycatpkg[1]==thispkgname:
				return 1
	else:
		# name and version specified
		for x in mypkgs:
			if mycatpkg[1]==x:
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

def pkgsame(pkg1,pkg2):
	if (string.split(pkg1,'-')[0])==(string.split(pkg2,'-')[0]):
		return 1
	else:
		return 0

def pkg(myname):
        return string.split(myname,'-')[0]

def ver(myname):
        a=string.split(myname,'-')
        return myname[len(a[0])+1:]



