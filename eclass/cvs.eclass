# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/cvs.eclass,v 1.2 2002/07/17 21:14:56 danarmak Exp $
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

# Where the cvs modules are stored/accessed
[ -z "$ECVS_TOP_DIR" ] && ECVS_TOP_DIR="/usr/src"

# Name of cvs server, set to "" to disable fetching
# (i.e. to assume module is checked out already and don't update it).
# Format is server:/dir e.g. "anoncvs.kde.org:/home/kde". remove the other
# parts of the full CVSROOT (which looks like
# ":pserver:anonymous@anoncvs.kde.org:/home/kde"); these are added from
# other settings
[ -z "$ECVS_SERVER" ] && ECVS_SERVER=""

# Username to use
[ -z "$ECVS_USER" ] && ECVS_USER="anonymous"

# Password to use (NOT (YET) SUPPORTED, because cvs doesn't store passwords in plaintext in .cvspass)
[ -z "$ECVS_PASS" ] && ECVS_PASS=""

# Module to be fetched, must be set explicitly -
# I don't like the former ="$NP" default setting
[ -z "$ECVS_MODULE" ] && die "$ECLASS: error: ECVS_MODULE not set, cannot continue"

# Subdirectory in module to be fetched, default is root "/" = whole module (NOT YET IMPLEMENTED)
[ -z "$ECVS_MODULE_SUBDIR" ] && ECVS_MODULE_SUBDIR="/"

# --- end ebuild-configurable settings ---

debug-print "$ECLASS: init: ECVS_CVS_COMMAND=$ECVS_CVS_COMMAND
ECVS_TOP_DIR=$ECVS_TOP_DIR
ECVS_SERVER=$ECVS_SERVER
ECVS_USER=$ECVS_USER
ECVS_PASS=$ECVS_PASS
ECS_MODULE=$ECVS_MODULE
ECVS_MODULE_SUBDIR=$ECVS_MODULE_SUBDIR"

# since we now longer have src_fetch as a redefinable ebuild function,
# we are forced to call this function from cvs_src_unpack
cvs_fetch() {

	debug-print-function $FUNCNAME $*

	# disable the sandbox for this dir
	[ ! -d "$ECVS_TOP_DIR" ] && mkdir -p $ECVS_TOP_DIR
	addread ${ECVS_TOP_DIR}
	addwrite ${ECVS_TOP_DIR}

	# prepare a cvspass file just for this session so that cvs thinks we're logged
	# in at the cvs server. we don't want to mess with ~/.cvspass.
	echo ":pserver:${ECVS_SERVER} A" > ${T}/cvspass
	export CVS_PASSFILE="${T}/cvspass"

	cd $ECVS_TOP_DIR

	if [ -z "$ECVS_SERVER" ]; then
		# we're not required to fetch anything, the module already exists and shouldn't be updated
	    if [ -d "$ECVS_MODULE" ]; then
			debug-print "$FUNCNAME: offline mode, exiting"
			return 0
	    else
			einfo "ERROR: Offline mode specified, but module not found. Aborting."
			debug-print "$FUNCNAME: offline mode specified but module not found, exiting with error"
			return 1
	    fi
	fi

	if [ -d "${ECVS_MODULE}" ]; then
		#update existing module

		cd ${ECVS_MODULE}

		# Switch servers if needed
		# cvs keeps the server info in th CVS/Root file in every checked-out dir;
		# we can fix those files to point to the new server
		newserver=":pserver:anonymous@${ECVS_SERVER}"
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

		debug-print "$FUNCNAME: running $ECVS_CVS_COMMAND update with $ECVS_SERVER for module $ECVS_MODULE"
		einfo "Running $ECVS_CVS_COMMAND update with $ECVS_SERVER for module $ECVS_MODULE..."
		$ECVS_CVS_COMMAND update -dP || die "died running cvs update"

	else 
	# checkout module

		export CVSROOT=:pserver:${ECVS_USER}@${ECVS_SERVER}
		debug-print "$FUNCNAME: running $ECVS_CVS_COMMAND checkout -P $ECVS_MODULE with $CVSROOT..."
		einfo "Running $ECVS_CVS_COMMAND checkout -P $ECVS_MODULE with $CVSROOT..."
		$ECVS_CVS_COMMAND checkout -P $ECVS_MODULE || die "died running cvs checkout"

	fi

}

cvs_src_unpack() {

    debug-print-function $FUNCNAME $*
	cvs_fetch || die "died running cvs_fetch"

    einfo "Copying module $ECVS_MODULE from $ECVS_TOP_DIR..."
	debug-print "Copying module $ECVS_MODULE from $ECVS_TOP_DIR..."
	# the reason this lives here and not in kde-source_src_unpack
	# is that in the future after copying the sources we might need to 
	# delete them, so this has to be self-contained
    cp -Rf ${ECVS_TOP_DIR}/${ECVS_MODULE} $WORKDIR

	# typically for kde cvs, the admin subdir lives in the kde-common module
	# which is also needed
	if [ ! -d "${WORKDIR}/${ECVS_MODULE}/admin" ]; then
		ECVS_MODULE="kde-common" cvs_fetch
	    einfo "Copying admin/ subdir from module kde-common, $ECVS_TOP_DIR..."
		debug-print "Copying admin/ subdir from module kde-common, $ECVS_TOP_DIR..."
    	cp -Rf ${ECVS_TOP_DIR}/${ECVS_MODULE} $WORKDIR
	fi
	
}

EXPORT_FUNCTIONS src_unpack

