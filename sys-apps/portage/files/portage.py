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

import string

# parsever:
# This function accepts an 'inter-period chunk' such as
# "3","4","3_beta5", or "2b" and returns an array of three
# integers. "3_beta5" returns [ 3, -2, 5 ]
# These values are used to determine which package is
# newer.

def relparse(myver):
	number=0
	p1=0
	p2=0
	mynewver=string.split(myver,"_")
	if len(mynewver)==2:
		#alpha,beta or pre
		number=string.atoi(mynewver[0])
		if "beta" == mynewver[1][:4]:
			p1=-2
			try:
				p2=string.atoi(mynewver[1][4:])
			except:
				p2=0
		elif "alpha" == mynewver[1][:5]:
			p1=-3
			try:
				p2=string.atoi(mynewver[1][5:])
			except:
				p2=0
		elif "pre" ==mynewver[1][:3]:
			p1=-1
			try:
				p2=string.atoi(mynewver[1][3:])
			except:
				p2=0
	else:
		#normal number or number with letter at end
		divider=len(myver)-1
		if myver[divider:] not in "1234567890":
			#letter at end
			p1=ord(myver[divider:])
			number=string.atoi(myver[0:divider])
		else:
			number=string.atoi(myver)		
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
# valid string in format: <v1>.<v2>...<vx>[a-z,_{alpha,beta,pre}[vy]]-vz

def ververify(myval):
	mybuildval=string.split(myval,'-')
	if len(mybuildval)==2:
		try:
			string.atoi(mybuildval[1])
			myval=mybuildval[0]
		except:
			return 0
	myval=string.split(myval,'.')
	for x in range(0,len(myval)-1):
		try:
			foo=string.atoi(myval[x])
		except:
			return 0
	endval=myval[-1:][0]
	try:
		string.atoi(endval)
		return 1
	except:
		pass
	pos=0
	keepgoing=1
	while keepgoing:
		if (pos<len(endval)) and (endval[pos] in "0123456789"):
			pos=pos+1
		else:
			keepgoing=0
	if pos==0:
		return 0
	endval=endval[pos:]
	if len(endval)==0:
		return 1
	if endval[0] in string.lowercase:
		if len(endval)>1:
			return 0
		else:
			return 1
	elif endval[0] == "_":
		endval=endval[1:]
		mylen=len(endval)
		if (mylen>=3) and (endval[0:3]=="pre"):
			if mylen==3:
				return 1
			else:
				try:
					string.atoi(endval[3:])
					return 1
				except:
					return 0
		elif (mylen>=4) and (endval[0:4]=="beta"):
			if mylen==4:
				return 1
			else:
				try:
					string.atoi(endval[4:])
					return 1
				except:
					return 0

		elif (mylen>=5) and (endval[0:5]=="alpha"):
			if mylen==5:
				return 1
			else:
				try:
					string.atoi(endval[5:])
					return 1
				except:
					return 0

		else:
			return 0
	else:
		return 0

# This function can be used as a package verification function, i.e.
# "pkgsplit("foo-1.2-1") will return None if foo-1.2-1 isn't a valid
# package (with version) name.  If it is a valid name, pkgsplit will
# return a list containing: [ pkgname, pkgversion(norev), pkgrev ].
# For foo-1.2-1, this list would be [ "foo", "1.2", "1" ].  For 
# Mesa-3.0, this list would be [ "Mesa", "3.0", "0" ].

def pkgsplit(mypkg):
	myparts=string.split(mypkg,'-')
	if len(myparts)<2:
		return None
	if revverify(myparts[-1]):
		if ververify(myparts[-2]):
			if len(myparts)==2:
				return None
			else:
				for x in myparts[:-2]:
					if ververify(x):
						return None
						#names can't have versiony looking parts
				return [string.join(myparts[:-2],"-"),myparts[-2],myparts[-1]]
		else:
			return None

	elif ververify(myparts[-1]):
		if len(myparts)==1:
			return None
		else:
			for x in myparts[:-1]:
				if ververify(x):
					return None
			return [string.join(myparts[:-1],"-"),myparts[-1],"0"]
	else:
		return None

# vercmp:
# This takes two version strings and returns an integer to tell you whether
# the versions are the same, val1>val2 or val2>val1.

def vercmp(val1,val2):
	val1=string.split(val1,'-')
	if len(val1)==2:
		val1[0]=val1[0]+"."+val1[1]
	val1=string.split(val1[0],'.')
	val2=string.split(val2,'-')
	if len(val2)==2:
		val2[0]=val2[0]+"."+val2[1]
	val2=string.split(val2[0],'.')
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

