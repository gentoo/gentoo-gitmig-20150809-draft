# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/cvs.eclass,v 1.35 2003/04/17 09:05:03 cretin Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# This eclass provides the generic cvs fetching functions.

ECLASS=cvs
INHERITED="$INHERITED $ECLASS"

# You shouldn't change these settings yourself! The ebuild/eclass inheriting this eclass
# will take care of that. If you want to set the global KDE cvs ebuilds' settings,
# see the comments in kde-source.eclass.

# --- begin ebuild-configurable settings

# cvs command to run. you can set fex. "cvs -t" for extensive debug information
# on the cvs onnection. the default of "cvs -q -f -z4" means to be quiet, to disregard
# the ~/.cvsrc config file and to use maximum compression.
[ -z "$ECVS_CVS_COMMAND" ] && ECVS_CVS_COMMAND="cvs -q -f -z4"

# cvs options given after the command (i.e. cvs update foo)
# don't remove -dP or things won't work
[ -z "$ECVS_CVS_OPTIONS" ] && ECVS_CVS_OPTIONS="-dP"

# set this for the module/subdir to be fetched non-recursively
#[ -n "$ECVS_LOCAL" ] && ECVS_CVS_OPTIONS="$ECVS_CVS_OPTIONS -l"

# Where the cvs modules are stored/accessed
[ -z "$ECVS_TOP_DIR" ] && ECVS_TOP_DIR="${DISTDIR}/cvs-src"

# Name of cvs server, set to "offline" to disable fetching
# (i.e. to assume module is checked out already and don't update it).
# Format is server:/dir e.g. "anoncvs.kde.org:/home/kde". remove the other
# parts of the full CVSROOT (which looks like
# ":pserver:anonymous@anoncvs.kde.org:/home/kde"); these are added from
# other settings
[ -z "$ECVS_SERVER" ] && ECVS_SERVER="offline"

# Anonymous cvs login?
# if 'yes' uses :pserver: with empty password, if 'no' uses :ext: with $ECVS_PASS, other values not allowed
[ -z "$ECVS_ANON" ] && ECVS_ANON="yes"

# Authentication method to use on ECVS_ANON="no" - possible values are "pserver" and "ext"
[ -z "$ECVS_AUTH" ] && ECVS_AUTH="ext"

# Use su to run cvs as user
[ -z "$ECVS_RUNAS" ] && ECVS_RUNAS="`whoami`"

# Username to use
[ -z "$ECVS_USER" ] && ECVS_USER="anonymous"

# Password to use if anonymous login is off, or if 'anonymous' pserver access
# uses a password and ECVS_ANON = yes
[ -z "$ECVS_PASS" ] && ECVS_PASS=""

# Module to be fetched, must be set explicitly -
# I don't like the former ="$PN" default setting
[ -z "$ECVS_MODULE" ] && debug-print "$ECLASS: error: ECVS_MODULE not set, cannot continue"

# Branch/tag to use, default is HEAD
# uncomment the following line to enable the reset-branch-to-HEAD behaviour
# [ -z "$ECVS_BRANCH" ] && ECVS_BRANCH="HEAD"

# Subdirectory in module to be fetched, default is not defined = whole module
# DO NOT set default to "", if it's defined at all code will break!
# don't uncomment following line!
#[ -z "$ECVS_SUBDIR" ] && ECVS_SUBDIR=""

# --- end ebuild-configurable settings ---

# add cvs to deps
DEPEND="$DEPEND dev-util/cvs dev-python/pexpect"

# since we no longer have src_fetch as a redefinable ebuild function,
# we are forced to call this function from cvs_src_unpack
cvs_fetch() {

	debug-print-function $FUNCNAME $*

	debug-print "$FUNCNAME: init:
9ECVS_CVS_COMMAND=$ECVS_CVS_COMMAND
ECVS_CVS_OPTIONS=$ECVS_CVS_OPTIONS
ECVS_TOP_DIR=$ECVS_TOP_DIR
ECVS_SERVER=$ECVS_SERVER
ECVS_ANON=$ECVS_ANON
ECVS_USER=$ECVS_USER
ECVS_PASS=$ECVS_PASS
ECS_MODULE=$ECVS_MODULE
ECVS_SUBDIR=$ECVS_SUBDIR
ECVS_LOCAL=$ECVS_LOCAL
DIR=$DIR"

	# a shorthand
	DIR="${ECVS_TOP_DIR}/${ECVS_MODULE}/${ECVS_SUBDIR}"
	debug-print "$FUNCNAME: now DIR=$DIR"

	if [ "$ECVS_SERVER" == "offline" ]; then
		# we're not required to fetch anything, the module already exists and shouldn't be updated
		if [ -d "$DIR" ]; then
			debug-print "$FUNCNAME: offline mode, exiting"
			return 0
		else
			einfo "ERROR: Offline mode specified, but module/subdir not found. Aborting."
			debug-print "$FUNCNAME: offline mode specified but module/subdir not found, exiting with error"
			return 1
		fi
	fi

	# create target directory as needed
	if [ ! -d "$DIR" ]; then
		debug-print "$FUNCNAME: creating cvs directory $DIR"
		#export SANDBOX_WRITE="$SANDBOX_WRITE:/foobar:/"
		addwrite /foobar
		addwrite /
		mkdir -p "/$DIR"
		export SANDBOX_WRITE="${SANDBOX_WRITE//:\/foobar:\/}"
	fi

	# in case ECVS_TOP_DIR is a symlink to a dir, get the real dir's path,
	# otherwise addwrite() doesn't work.
	cd -P "$ECVS_TOP_DIR" > /dev/null
	ECVS_TOP_DIR="`/bin/pwd`"
	DIR="${ECVS_TOP_DIR}/${ECVS_MODULE}/${ECVS_SUBDIR}"
	cd "$OLDPWD"
	
	debug-print "$FUNCNAME: now DIR=$DIR"
	
	# disable the sandbox for this dir
	# not just $DIR because we want to create moduletopdir/CVS too
	addwrite "$ECVS_TOP_DIR/$ECVS_MODULE"

	# add option for local (non-recursive) fetching
	[ -n "$ECVS_LOCAL" ] && ECVS_CVS_OPTIONS="$ECVS_CVS_OPTIONS -l"
	
	# prepare a cvspass file just for this session, we don't want to mess with ~/.cvspass
	touch "${T}/cvspass"
	export CVS_PASSFILE="${T}/cvspass"
	chown $ECVS_RUNAS "${T}/cvspass"

	# Note: cvs update and checkout commands are unified.
	# we make sure a CVS/ dir exists in our module subdir with the right
	# Root and Repository entries in it and cvs update.
	
	[ "${ECVS_ANON}" == "yes" ] && \
		newserver=":pserver:${ECVS_USER}@${ECVS_SERVER}" || \
		newserver=":${ECVS_AUTH}:${ECVS_USER}@${ECVS_SERVER}" 
		
	
	# CVS/Repository files can't (I think) contain two concatenated slashes
	if [ -n "$ECVS_SUBDIR" ]; then
		repository="${ECVS_MODULE}/${ECVS_SUBDIR}"
	else
		repository="${ECVS_MODULE}"
	fi
	
	debug-print "$FUNCNAME: Root<-$newserver, Repository<-$repository"
	debug-print "$FUNCNAME: entering directory $DIR"
	cd "/$DIR"
	
	if [ ! -d "CVS" ]; then
		# create a new CVS/ directory (checkout)
		debug-print "$FUNCNAME: creating new cvs directory"
		
		mkdir CVS
		echo $newserver > CVS/Root
		echo $repository > CVS/Repository
		touch CVS/Entries
		
		# if we're checking out a subdirectory only, create a CVS/ dir
		# in the module's top dir so that the user (and we) can cvs update
		# from there to get the full module.
		if [ ! -d "$ECVS_TOP_DIR/$ECVS_MODULE/CVS" ]; then
			debug-print "$FUNCNAME: Copying CVS/ directory to module top-level dir"
			cp -r CVS "$ECVS_TOP_DIR/$ECVS_MODULE/"
			echo $ECVS_MODULE > "$ECVS_TOP_DIR/$ECVS_MODULE/CVS/Repository"
		fi
		
	else
		#update existing module
		debug-print "$FUNCNAME: updating existing module/subdir"
		
		# Switch servers if needed
		# cvs keeps the server info in the CVS/Root file in every checked-out dir;
		# we can fix those files to point to the new server
		oldserver="`cat CVS/Root`"
		if [ "$newserver" != "$oldserver" ]; then

			einfo "Changing CVS server from $oldserver to $newserver:"
			debug-print "$FUNCNAME: Changing CVS server from $oldserver to $newserver:"

			einfo "Searching for CVS dirs..."
			cvsdirs="`find . -iname CVS -print`"
			debug-print "$FUNCNAME: CVS dirs found:"
			debug-print "$cvsdirs"

			einfo "Modifying CVS dirs..."
			for x in $cvsdirs; do
				debug-print "In $x"
				echo $newserver > "$x/Root"
			done

		fi

	fi

	# cvs auto-switches branches, how nice
	# warning: if we do it this way we get multiple -rX options - harmless i think
	[ -n "$ECVS_BRANCH" ] && ECVS_CVS_OPTIONS="$ECVS_CVS_OPTIONS -r$ECVS_BRANCH"

	# Chowning the directory
	if [ "${ECVS_RUNAS}" != "`whoami`" ]; then
		chown -R "$ECVS_RUNAS" "/$DIR"
	fi

	# finally run the cvs update command
	debug-print "$FUNCNAME: is in dir `/bin/pwd`"
	debug-print "$FUNCNAME: running $ECVS_CVS_COMMAND update $ECVS_CVS_OPTIONS with $ECVS_SERVER for module $ECVS_MODULE subdir $ECVS_SUBDIR"
	einfo "Running $ECVS_CVS_COMMAND update $ECVS_CVS_OPTIONS with $ECVS_SERVER for $ECVS_MODULE/$ECVS_SUBDIR..."

	if [ "${ECVS_ANON}" == "no" ]; then
	
		debug-print "$FUNCNAME: starting non-anonymous cvs login..."
		# CVS Login - written in python :: the right way ;)
		# Tilman Klar, <phoenix@gentoo.org>

		export CVS_RSH="/usr/bin/ssh"

############################## inline-python #####################################
/usr/bin/env python << EndOfFile

import pexpect,os

mypasswd  = "${ECVS_PASS}"
myauth    = "${ECVS_AUTH}"
mytimeout = 10

if "${ECVS_RUNAS}" == "`whoami`":
    mycommand = "${ECVS_CVS_COMMAND} update ${ECVS_CVS_OPTIONS}"
else:
    mycommand = "su ${ECVS_RUNAS} -c \"${ECVS_CVS_COMMAND} update ${ECVS_CVS_OPTIONS}\""

if myauth == "ext":
	child = pexpect.spawn(mycommand)

	index = child.expect(['continue connecting','word:'], mytimeout)
	if index == 0:
		child.sendline('yes')
		## Added server to ~/.ssh/known_hosts
		child.expect('word:', mytimeout)
	else:
		## Server already is in ~/.ssh/known_hosts
		pass

	child.sendline(mypasswd)
	child.expect(pexpect.EOF)	

elif myauth == "pserver":
	if "${ECVS_RUNAS}" == "`whoami`":
		mycommand2 = "cvs login"
	else:
		mycommand2 = "su ${ECVS_RUNAS} -c \"cvs login\""
	child = pexpect.spawn(mycommand2)
	child.expect("CVS password:",mytimeout)
	child.sendline(mypasswd)
	child.expect(pexpect.EOF)

	# Logged in - checking out
	os.system(mycommand)
	
EndOfFile
########################### End of inline-python ##################################
	else
		# is anonymous cvs.
		# is there a password to use for login with this "anonymous" login
		if [ -n "$ECVS_PASS" ]; then
			debug-print "$FUNCNAME: using anonymous cvs login with password"

# inline-python #
/usr/bin/env python << EndOfFile

import pexpect,os

myuser	  = "${ECVS_USER}"
mypasswd  = "${ECVS_PASS}"

mytimeout = 10

# implicitly myauth == "pserver" here.
mycommand = "cvs login"
child = pexpect.spawn(mycommand)
child.expect("CVS password:",mytimeout)
child.sendline(mypasswd)
child.expect(pexpect.EOF)
EndOfFile
# End of inline-python #

		else
		    debug-print "$FUNCNAME: using anonymous cvs login (without password)"
		    # passwordless, truly anonymous login; or login with empty (but existing)
		    # password.
		    # make cvs think we're logged in at the cvs server,
		    # because i don't trust myself to write the right code for the case
		    # where the password is empty but still required (what's the bash test
		    # to see if a variable is defined? -n returns false if it is defined
		    # but empty...)
		    echo ":pserver:${ECVS_SERVER} A" > "${T}/cvspass"
		    # remember we did this so we don't try to run cvs logout later
		    DONT_LOGOUT=yes
		fi

		debug-print "$FUNCNAME: running $ECVS_CVS_COMMAND update $ECVS_CVS_OPTIONS"
		$ECVS_CVS_COMMAND update $ECVS_CVS_OPTIONS || die "died running cvs update"

	fi

	# log out and restore ownership as needed
	if [ -z "$DONT_LOGOUT" ]; then
	    debug-print "$FUNCNAME: cvs logout stuff"
	    if [ "$ECVS_RUNAS" == "`whoami`" ]; then
		cvs logout &> /dev/null
	    else
		su $ECVS_RUNAS -c "cvs logout" &> /dev/null
	    fi
	fi
	chown `whoami` "${T}/cvspass"
}

cvs_src_unpack() {

	debug-print-function $FUNCNAME $*
	cvs_fetch || die "died running cvs_fetch"

	einfo "Copying $ECVS_MODULE/$ECVS_SUBDIR from $ECVS_TOP_DIR..."
	debug-print "Copying module $ECVS_MODULE subdir $ECVS_SUBDIR local_mode=$ECVS_LOCAL from $ECVS_TOP_DIR..."
	
	# probably redundant, but best to make sure
	mkdir -p "$WORKDIR/$ECVS_MODULE/$ECVS_SUBDIR"
	
	if [ -n "$ECVS_SUBDIR" ]; then
		if [ -n "$ECVS_LOCAL" ]; then
			cp -f "$ECVS_TOP_DIR/$ECVS_MODULE/$ECVS_SUBDIR"/* "$WORKDIR/$ECVS_MODULE/$ECVS_SUBDIR"
		else
			cp -Rf "$ECVS_TOP_DIR/$ECVS_MODULE/$ECVS_SUBDIR" "$WORKDIR/$ECVS_MODULE/$ECVS_SUBDIR/.."
		fi    
	else
		if [ -n "$ECVS_LOCAL" ]; then
			cp -f "$ECVS_TOP_DIR/$ECVS_MODULE"/* $WORKDIR/$ECVS_MODULE
		else
			cp -Rf "$ECVS_TOP_DIR/$ECVS_MODULE" "$WORKDIR"
		fi
	fi
	
	# if the directory is empty, remove it; empty directories cannot exist in cvs.
	# this happens when fex. kde-source requests module/doc/subdir which doesn't exist.
	# still create the empty directory in workdir though.
	if [ "`ls -A \"$DIR\"`" == "CVS" ]; then
		debug-print "$FUNCNAME: removing cvs-empty directory $ECVS_MODULE/$ECVS_SUBDIR"
		rm -rf "$DIR"
	fi
	    
	# implement some of base_src_unpack's functionality;
	# note however that base.eclass may not have been inherited!
	if [ -n "$PATCHES" ]; then
		debug-print "$FUNCNAME: PATCHES=$PATCHES, S=$S, autopatching"
		cd "$S"
		for x in $PATCHES; do
			debug-print "patching from $x"
			patch -p0 < "$x"
		done
		# make sure we don't try to apply patches more than once, since
		# cvs_src_unpack is usually called several times from e.g. kde-source_src_unpack
		export PATCHES=""
	fi

}

EXPORT_FUNCTIONS src_unpack
