# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-source.eclass,v 1.2 2002/07/18 17:37:32 danarmak Exp $

# This is for kde-base cvs ebuilds. Read comments about settings.
# It uses $S and sets $SRC_URI, so inherit it as late as possible (certainly after any other eclasses).
# See http://www.gentoo.org/~danarmak/kde-cvs.html !
# All of the real functionality is in cvs.eclass; this just adds some trivial kde-specific items

ECLASS=kde-source
INHERITED="$INHERITED $ECLASS"

# --- begin user-configurable settings ---

# Set yours in profile (e.g. make.conf), or export from the command line to override.
# Most have acceptable default values or are set by the ebuilds, but be sure to read the comments
# in cvs.eclass for detailed descriptions of them all.
# You should probably set at least ECVS_SERVER.

# TODO: add options to store the modules as tarballs in $DISTDIR or elsewhere

# Under this directory the cvs modules are stored/accessed
# Storing in tarballs in $DISTDIR to be implemented soon
[ -z "$ECVS_TOP_DIR" ] && ECVS_TOP_DIR="/usr/src/kde"

# Set to name of cvs server. Set to "" to disable fetching (offline mode).
# In offline mode, we presume that modules are already checked out at the specified
# location and that they shouldn't be updated.
# Format example: "anoncvs.kde.org:/home/kde" (without :pserver:anonymous@ part)
# Mirror list is available at http://developer.kde.org/source/anoncvs.html
[ -z "$ECVS_SERVER" ] && ECVS_SERVER="anoncvs.kde.org:/home/kde"

# default for kde-base ebuilds
[ -z "$ECVS_MODULE" ] && ECVS_MODULE="$PN"

# Other variables: see cvs.eclass

# --- end user-configurable settings ---

# cvs modules don't have a version in their names
S="$WORKDIR/$PN" 

DESCRIPTION="$DESCRIPTION (cvs) "

# set this to more easily maintain cvs and std ebuilds side-by-side
# (we don't need to remove SRC_URI, kde-dist.eclass, kde.org.eclass etc
# from the cvs ones). To download patches or something, set SRC_URI again after
# inheriting kde_source.
SRC_URI=""

kde-source_src_unpack() {

    debug-print-function $FUNCNAME $*

	# we do this here and not in the very beginning because we need to keep
	# the configuration order intact: env. and profile settings override
	# kde-source.eclass defaults, which in turn override cvs.eclass defaults
	inherit cvs
	
	# this fetches cvs sources and copies them to $WORKDIR
	cvs_src_unpack
	
	# typically for kde cvs, the admin subdir lives in the kde-common module
	# which is also needed
	if [ ! -d "${WORKDIR}/${ECVS_MODULE}/admin" ]; then
		ECVS_MODULE="kde-common" cvs_src_unpack
		einfo "Copying admin/ subdir from module kde-common..."
		debug-print "Copying admin/ subdir from module kde-common..."
    	mv ${WORKDIR}/kde-common/admin ${WORKDIR}/${ECVS_MODULE}/
	fi
	
	# make sure checked-out module is accessible at $S, in case
	# the ebuild overrode our S=$WORKDIR/$PN setting
	if [ "$S" != "$WORKDIR/$PN" ]; then
		cd $WORKDIR
		ln -sf $PN $S
	fi
	
	# make sure we give them a clean cvs checkout
	cd ${S}
	[ -f "Makefile" ] && make cvs-clean
	[ -f "config.cache" ] && rm config.cache

}


EXPORT_FUNCTIONS src_unpack

