# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/cvs.eclass,v 1.13 2002/08/19 16:56:49 danarmak Exp $
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
[ -z "$ECVS_TOP_DIR" ] && ECVS_TOP_DIR="/usr/src"

# Name of cvs server, set to "offline" to disable fetching
# (i.e. to assume module is checked out already and don't update it).
# Format is server:/dir e.g. "anoncvs.kde.org:/home/kde". remove the other
# parts of the full CVSROOT (which looks like
# ":pserver:anonymous@anoncvs.kde.org:/home/kde"); these are added from
# other settings
[ -z "$ECVS_SERVER" ] && ECVS_SERVER="offline"

# Username to use
[ -z "$ECVS_USER" ] && ECVS_USER="anonymous"

# Password to use (NOT (YET) SUPPORTED, because cvs doesn't store passwords in plaintext in .cvspass)
[ -z "$ECVS_PASS" ] && ECVS_PASS=""

# Module to be fetched, must be set explicitly -
# I don't like the former ="$PN" default setting
[ -z "$ECVS_MODULE" ] && debug-print "$ECLASS: error: ECVS_MODULE not set, cannot continue"

# Subdirectory in module to be fetched, default is not defined = whole module
# DO NOT set default to "", if it's defined at all code will break!
# don't uncomment following line!
#[ -z "$ECVS_MODULE_SUBDIR" ] && ECVS_MODULE_SUBDIR=""

# --- end ebuild-configurable settings ---

# add cvs to deps
DEPEND="$DEPEND dev-util/cvs"

# since we now longer have src_fetch as a redefinable ebuild function,
# we are forced to call this function from cvs_src_unpack
cvs_fetch() {

	debug-print-function $FUNCNAME $*

	debug-print "$FUNCNAME: init:
ECVS_CVS_COMMAND=$ECVS_CVS_COMMAND
ECVS_CVS_OPTIONS=$ECVS_CVS_OPTIONS
ECVS_TOP_DIR=$ECVS_TOP_DIR
ECVS_SERVER=$ECVS_SERVER
ECVS_USER=$ECVS_USER
ECVS_PASS=$ECVS_PASS
ECS_MODULE=$ECVS_MODULE
ECVS_MODULE_SUBDIR=$ECVS_SUBDIR
ECVS_LOCAL=$ECVS_LOCAL
DIR=$DIR"
	
	# a shorthand
	[ -n "$ECVS_SUBDIR" ] && DIR="${ECVS_TOP_DIR}/${ECVS_MODULE}/${ECVS_SUBDIR}" || \
							DIR="${ECVS_TOP_DIR}/${ECVS_MODULE}"

	[ -n "$ECVS_LOCAL" ] && ECVS_CVS_OPTIONS="$ECVS_CVS_OPTIONS -l"
	
	addread $DIR
	
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

	# disable the sandbox for this dir
	
	# not just $DIR because we want to create moduletopdir/CVS too
	addwrite $ECVS_TOP_DIR/$ECVS_MODULE
	
	if [ ! -d "$DIR" ]; then
		debug-print "$FUNCNAME: creating cvs directory $DIR"
		einfo "Creating directory $DIR"
		export SANDBOX_WRITE="$SANDBOX_WRITE:/foo:/"
		mkdir -p /$DIR
		export SANDBOX_WRITE=${SANDBOX_WRITE//:\/foo:\/}
	fi

	# prepare a cvspass file just for this session so that cvs thinks we're logged
	# in at the cvs server. we don't want to mess with ~/.cvspass.
	echo ":pserver:${ECVS_SERVER} A" > ${T}/cvspass
	export CVS_PASSFILE="${T}/cvspass"
	#export CVSROOT=:pserver:${ECVS_USER}@${ECVS_SERVER}
		
	# Note: cvs update and checkout commands are unified.
	# we make sure a CVS/ dir exists in our module subdir with the right
	# Root and Repository entries in it and cvs update.
	
	newserver=":pserver:${ECVS_USER}@${ECVS_SERVER}"
	
	# CVS/Repository files can't (I think) contain two concatenated slashes
	if [ -n "$ECVS_SUBDIR" ]; then
		repository="${ECVS_MODULE}/${ECVS_SUBDIR}"
	else
		repository="${ECVS_MODULE}"
	fi
	
	debug-print "$FUNCNAME: Root<-$newserver, Repository<-$repository"

	cd $DIR
	if [ ! -d "$DIR/CVS" ]; then
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
			cp -r CVS $ECVS_TOP_DIR/$ECVS_MODULE/
			echo $ECVS_MODULE > $ECVS_TOP_DIR/$ECVS_MODULE/CVS/Repository
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
				echo $newserver > $x/Root
			done

		fi

	fi

	# finally run the cvs update command
	debug-print "$FUNCNAME: running $ECVS_CVS_COMMAND update $ECVS_CVS_OPTIONS with $ECVS_SERVER for module $ECVS_MODULE subdir $ECVS_SUBDIR"
	einfo "Running $ECVS_CVS_COMMAND update $ECVS_CVS_OPTIONS with $ECVS_SERVER for $ECVS_MODULE/$ECVS_SUBDIR..."
	$ECVS_CVS_COMMAND update $ECVS_CVS_OPTIONS || die "died running cvs update"

}

cvs_src_unpack() {

    debug-print-function $FUNCNAME $*
	cvs_fetch || die "died running cvs_fetch"

    einfo "Copying module $ECVS_MODULE from $ECVS_TOP_DIR..."
	debug-print "Copying module $ECVS_MODULE from $ECVS_TOP_DIR..."
	
	if [ -n "$ECVS_SUBDIR" ]; then
			mkdir -p $WORKDIR/$ECVS_MODULE/$ECVS_SUBDIR
			cp -Rf $ECVS_TOP_DIR/$ECVS_MODULE/$ECVS_SUBDIR/* $WORKDIR/$ECVS_MODULE/$ECVS_SUBDIR/
	else
		if [ -n "$ECVS_LOCAL" ]; then
			cp -f $ECVS_TOP_DIR/$ECVS_MODULE/* $WORKDIR/$ECVS_MODULE
		else
			cp -Rf $ECVS_TOP_DIR/$ECVS_MODULE $WORKDIR
		fi
	fi
	
	# if the directory is empty, remove it; empty directories cannot exist in cvs.
	# this happens when fex. kde-source requests module/doc/subdir which doesn't exist.
	# still create the empty directory in workdir though.
	if [ "`ls -A $DIR`" == "CVS" ]; then
		debug-print "$FUNCNAME: removing cvs-empty directory $ECVS_MODULE/$ECVS_SUBDIR"
		rm -rf $DIR
	fi
	    
    # implement some of base_src_unpack's functionality;
    # note however that base.eclass may not have been inherited!
    if [ -n "$PATCHES" ]; then
	debug-print "$FUNCNAME: PATCHES=$PATCHES, S=$S, autopatching"
	cd $S
	for x in $PATCHES; do
	    debug-print "patching from $x"
	    patch -p0 < $x
	done
	# make sure we don't try to apply patches more than once, since
	# cvs_src_unpack is usually called several times from e.g. kde-source_src_unpack
	export PATCHES=""
    fi

}

EXPORT_FUNCTIONS src_unpack


