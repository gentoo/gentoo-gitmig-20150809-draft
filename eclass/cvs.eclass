# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/cvs.eclass,v 1.38 2003/04/22 20:43:29 danarmak Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# This eclass provides the generic cvs fetching functions.
# to use from an ebuild, set the 'ebuild-configurable settings' below in your ebuild before inheriting.
# then either leave the default src_unpack or extend over cvs_src_unpack.
# if you find that you need to call the cvs_* functions directly, i'd be interested to hear about it.

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

# cvs options given after the cvs command (update or checkout)
# don't remove -dP from update or things won't work
[ -z "$ECVS_UP_OPTS" ] && ECVS_UP_OPTS="-dP"
[ -z "$ECVS_CO_OPTS" ] && ECVS_CO_OPTS=""

# set this to some value for the module/subdir to be fetched non-recursively: ECVS_LOCAL

# Where the cvs modules are stored/accessed
[ -z "$ECVS_TOP_DIR" ] && ECVS_TOP_DIR="${DISTDIR}/cvs-src"

# Name of cvs server, set to "offline" to disable fetching
# (i.e. to assume module is checked out already and don't update it).
# Format is server:/dir e.g. "anoncvs.kde.org:/home/kde". remove the other
# parts of the full CVSROOT (which looks like
# ":pserver:anonymous@anoncvs.kde.org:/home/kde"); these are added from
# other settings
# the special value 'offline' disables fetching, assumes sources are alread in ECVS_TOP_DIR
[ -z "$ECVS_SERVER" ] && ECVS_SERVER="offline"

# Authentication method to use - possible values are "pserver" and "ext"
# WARNING ext is NOT supported! (never was, despite what earlier version of this file said)
[ -z "$ECVS_AUTH" ] && ECVS_AUTH="pserver"
[ "$ECVS_AUTH" == ext ] && die "ERROR: ext auth not supported. If you want it, please contact danarmak@gentoo.org."

# Use su to run cvs as user
# Currently b0rked and wouldn't work with portage userpriv anyway without special magic
# [ -z "$ECVS_RUNAS" ] && ECVS_RUNAS="`whoami`"

# Username to give to the server
[ -z "$ECVS_USER" ] && ECVS_USER="anonymous"

# Password to use
[ -z "$ECVS_PASS" ] && ECVS_PASS=""

# Module to be fetched, must be set when kde_src_unpack is called
# can include several directory levels, ie foo/bar/baz
#[ -z "$ECVS_MODULE" ] && die "$ECLASS: error: ECVS_MODULE not set, cannot continue"

# Branch/tag to use, default is HEAD
# the following default _will_ reset your branch checkout to head if used
#[ -z "$ECVS_BRANCH" ] && ECVS_BRANCH="HEAD"

# deprecated - do not use
[ -n "$ECVS_SUBDIR" ] && die "ERROR: deprecated ECVS_SUBDIR defined. Please fix this ebuild."

# --- end ebuild-configurable settings ---

# add cvs to deps
# ssh is used for ext auth
# sudo is used to run as a specified user
DEPEND="$DEPEND dev-util/cvs app-admin/sudo"
#[ "$ECVS_AUTH" == "ext" ] && DEPEND="$DEPEND net-misc/openssh"

# calls cvs_contorl, is called from cvs_src_unpack
cvs_fetch() {

	debug-print-function $FUNCNAME $*

	# parameters modifying other parameters that should be effective every time cvs_fetch is called,
	# and not just every time cvs.eclas is inherited
	# 1. parameter for local (non-recursive) fetching
	if [ -n "$ECVS_LOCAL" ]; then
		ECVS_UP_OPTS="$ECVS_UP_OPTS -l"
		ECVS_CO_OPTS="$ECVS_CO_OPTS -l"
	fi
	# 2. cvs auto-switches branches, we just have to pass the correct -rBRANCH option to it when updating.
	# doing it this way we get multiple -rX options - harmless afaik
	if [ -n "$ECVS_BRANCH" ]; then
		ECVS_UP_OPTS="$ECVS_UP_OPTS -r$ECVS_BRANCH"
		ECVS_CO_OPTS="$ECVS_CO_OPTS -r$ECVS_BRANCH"
	fi

	# it's easiest to always be in "run-as mode", logic-wise
	# or would be if sudo didn't ask for a password even when sudo'ing to `whoami`
	if [ -z "$ECVS_RUNAS" ]; then
		run=""
	else
		run="sudo -u $ECVS_RUNAS"
	fi

	# create the top dir if needed
	if [ ! -d "$ECVS_TOP_DIR" ]; then
		# note that the addwrite statements in this block are only there to allow creating ECVS_TOP_DIR;
		# we've already allowed writing inside it
		# this is because it's simpler than trying to find out the parent path of the directory, which
		# would need to be the real path and not a symlink for things to work (so we can't just remove
		# the last path element in the string)
		debug-print "$FUNCNAME: checkout mode. creating cvs directory"
		addwrite /foobar
		addwrite /
		$run mkdir -p "/$ECVS_TOP_DIR"
		export SANDBOX_WRITE="${SANDBOX_WRITE//:\/foobar:\/}"
	fi

	# in case ECVS_TOP_DIR is a symlink to a dir, get the real dir's path,
	# otherwise addwrite() doesn't work.
	cd -P "$ECVS_TOP_DIR" > /dev/null
	ECVS_TOP_DIR="`/bin/pwd`"

	# determine checkout or update mode
	if [ ! -d "$ECVS_TOP_DIR/$ECVS_MODULE/CVS" ]; then
		mode=checkout
	else
		mode=update
	fi

	# disable the sandbox for this dir
	addwrite "$ECVS_TOP_DIR"

	# chowning the directory and all contents
	if [ -n "$ECVS_RUNAS" ]; then
		$run chown -R "$ECVS_RUNAS" "/$ECVS_TOP_DIR"
	fi

	# our server string (aka CVSROOT), without the password so it can be put in Root
	server=":${ECVS_AUTH}:${ECVS_USER}@${ECVS_SERVER}"

	# switch servers automagically if needed
	if [ "$mode" == "update" ]; then
		cd /$ECVS_TOP_DIR/$ECVS_MODULE
		oldserver="`$run cat CVS/Root`"
		if [ "$server" != "$oldserver" ]; then

			einfo "Changing CVS server from $oldserver to $server:"
			debug-print "$FUNCNAME: Changing CVS server from $oldserver to $server:"

			einfo "Searching for CVS dirs..."
			cvsdirs="`$run find . -iname CVS -print`"
			debug-print "$FUNCNAME: CVS dirs found:"
			debug-print "$cvsdirs"

			einfo "Modifying CVS dirs..."
			for x in $cvsdirs; do
				debug-print "In $x"
				$run echo "$server" > "$x/Root"
			done

		fi
	fi

	# prepare a cvspass file just for this session, we don't want to mess with ~/.cvspass
	touch "${T}/cvspass"
	export CVS_PASSFILE="${T}/cvspass"
	if [ -n "$ECVS_RUNAS" ]; then
		chown "$ECVS_RUNAS" "${T}/cvspass"
	fi

	# the server string with the password in it, for login
	cvsroot_pass=":${ECVS_AUTH}:${ECVS_USER}:${ECVS_PASS}@${ECVS_SERVER}"
	# ditto without the password, for checkout/update after login, so that
	# the CVS/Root files don't contain the password in plaintext
	cvsroot_nopass=":${ECVS_AUTH}:${ECVS_USER}@${ECVS_SERVER}"

	# commands to run
	cmdlogin="${run} ${ECVS_CVS_COMMAND} -d \"${cvsroot_pass}\" login"
	cmdupdate="${run} ${ECVS_CVS_COMMAND} -d \"${cvsroot_nopass}\" update ${ECVS_UP_OPTS} ${ECVS_MODULE}"
	cmdcheckout="${run} ${ECVS_CVS_COMMAND} -d \"${cvsroot_nopass}\" checkout ${ECVS_CO_OPTS} ${ECVS_MODULE}"

	cd "${ECVS_TOP_DIR}"
	if [ "${ECVS_AUTH}" == "pserver" ]; then
		einfo "Running $cmdlogin"
		eval $cmdlogin
		if [ "${mode}" == "update" ]; then
			einfo "Running $cmdupdate"
			eval $cmdupdate
		elif [ "${mode}" == "checkout" ]; then
			einfo "Running $cmdcheckout"
			eval $cmdcheckout
		fi
#	elif [ "${ECVS_AUTH}" == "ext" ]; then
#		# for ext there's also a possible ssh prompt, code not yet written
#		echo "${ECVS_DELAY} continue connecting&yes" >> "$instruct"
#		echo "${ECVS_DELAY} CVS password:&${ECVS_PASS}" >> "$instruct"
#		if [ "$mode" == "update" ]; then
#			expect "$cvsout" "$instruct" | $cmdupdate > "$cvsout"
#		elif [ "$mode" == "checkout" ]; then
#			expect "$cvsout" "$instruct" | $cmdcheckout > "$cvsout"
#		fi
	fi

	# restore ownership. not sure why this is needed, but someone added it in the orig ECVS_RUNAS stuff.
	if [ -n "$ECVS_RUNAS" ]; then
		chown `whoami` "${T}/cvspass"
	fi

}


cvs_src_unpack() {

	debug-print-function $FUNCNAME $*

	debug-print "$FUNCNAME: init:
ECVS_CVS_COMMAND=$ECVS_CVS_COMMAND
ECVS_UP_OPTS=$ECVS_UP_OPTS
ECVS_CO_OPTS=$ECVS_CO_OPTS
ECVS_TOP_DIR=$ECVS_TOP_DIR
ECVS_SERVER=$ECVS_SERVER
ECVS_USER=$ECVS_USER
ECVS_PASS=$ECVS_PASS
ECS_MODULE=$ECVS_MODULE
ECVS_LOCAL=$ECVS_LOCAL
ECVS_RUNAS=$ECVS_RUNAS"

	[ -z "$ECVS_MODULE" ] && die "ERROR: CVS module not set, cannot continue."

	if [ "$ECVS_SERVER" == "offline" ]; then
		# we're not required to fetch anything, the module already exists and shouldn't be updated
	 		if [ -d "${ECVS_TOP_DIR}/${ECVS_MODULE}" ]; then
			debug-print "$FUNCNAME: offline mode, exiting"
			return 0
		else
			debug-print "$FUNCNAME: offline mode specified but module/subdir not found, exiting with error"
			die "ERROR: Offline mode specified, but module/subdir checkout not found. Aborting."
		fi
	elif [ -n "$ECVS_SERVER" ]; then # ECVS_SERVER!=offline --> real fetching mode
		einfo "Fetching cvs module $ECVS_MODULE into $ECVS_TOP_DIR..."
		cvs_fetch
	else	# ECVS_SERVER not set
		die "ERROR: CVS server not set, cannot continue."
	fi

	einfo "Copying $ECVS_MODULE from $ECVS_TOP_DIR..."
	debug-print "Copying module $ECVS_MODULElocal_mode=$ECVS_LOCAL from $ECVS_TOP_DIR..."

	# probably redundant, but best to make sure
	mkdir -p "$WORKDIR/$ECVS_MODULE"

	if [ -n "$ECVS_LOCAL" ]; then
		mkdir -p "$WORKDIR/$ECVS_MODULE"
		cp -f "$ECVS_TOP_DIR/$ECVS_MODULE"/* "$WORKDIR/$ECVS_MODULE"
	else
		cp -Rf "$ECVS_TOP_DIR/$ECVS_MODULE" "$WORKDIR/$ECVS_MODULE/.."
	fi

	# if the directory is empty, remove it; empty directories cannot exist in cvs.
	# this happens when fex. kde-source requests module/doc/subdir which doesn't exist.
	# still create the empty directory in workdir though.
	if [ "`ls -A \"${ECVS_TOP_DIR}/${ECVS_MODULE}\"`" == "CVS" ]; then
		debug-print "$FUNCNAME: removing cvs-empty directory $ECVS_MODULE"
		rm -rf "${ECVS_TOP_DIR}/${ECVS_MODULE}"
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
