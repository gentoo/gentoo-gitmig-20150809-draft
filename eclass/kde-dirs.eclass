# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-dirs.eclass,v 1.2 2002/01/16 20:45:37 danarmak Exp $
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.
ECLASS=kde-dirs

need-kde() {

	debug-print-function $FUNCNAME $*
	KDEVER="$1"
	
	#newdepend ">=kde-base/kdelibs-$KDEVER"
	min-kde-ver $KDEVER
	newdepend ">=kde-base/kdelibs-${selected_version}"
	set-kdedir $KDEVER

	qtver-from-kdever $KDEVER
	need-qt $selected_version

}

set-kdedir() {

	debug-print-function $FUNCNAME $*
	
	# for older make.globals versions which don't include the default KDE?DIR settings
	[ -z "$KDE2DIR" ] && export KDE2DIR="/usr/kde/2"
	[ -z "$KDE3DIR" ] && export KDE3DIR="/usr/kde/3"
	# not defined at all by default
	[ -z "$KDE2LIBSDIR" ] && export KDE2LIBSDIR="$KDE2DIR" 
	[ -z "$KDE3LIBSDIR" ] && export KDE3LIBSDIR="$KDE3DIR" 
	
	local KDEVER
	KDEVER=$1

	# select 1st element in dot-separated string
	IFSBACKUP=$IFS
	IFS="."
	KDEMAJORVER=""
	for x in $KDEVER; do
		[ -z "$KDEMAJORVER" ] && KDEMAJORVER=$x
	done
	IFS=$IFSBACKUP
	
	case $KDEMAJORVER in
	    2) export KDEDIR=${KDE2LIBSDIR};;
	    3) export KDEDIR=${KDE3LIBSDIR};;
	esac
	
	echo in set-kdedir, info:
	echo "KDEDIR=$KDEDIR; KDE2DIR=$KDE2DIR; KDE3DIR=$KDE3DIR"
	echo "KDE2LIBSDIR=$KDE2LIBSDIR KDE3LIBSDIR=$KDE3LIBSDIR; KDEMAJORVER=$KDEMAJORVER; KDEVER=$KDEVER"
	
	debug-print "$FUNCNAME: result: KDEDIR=$KDEDIR"

}

need-qt() {

	debug-print-function $FUNCNAME $*
	QTVER="$1"
	#newdepend ">=x11-libs/qt-$QTVER"
	min-qt-ver $QTVER
	newdepend ">=x11-libs/qt-$selected_version"
	set-qtdir $QTVER

}

set-qtdir() {

	debug-print-function $FUNCNAME $*

	local QTVER
	QTVER=$1

	# select 1st element in dot-separated string
	IFSBACKUP=$IFS
	IFS="."
	QTMAJORVER=""
	for x in $QTVER; do
		[ -z "$QTMAJORVER" ] && QTMAJORVER=$x
	done
	IFS=$IFSBACKUP

	export QTDIR="/usr/qt/$QTMAJORVER"

}

# returns minimal qt version needed for specified kde version
qtver-from-kdever() {

	debug-print-function $FUNCNAME $*

	local ver

	case $1 in
		2*)	ver=2.3.1;;
		3*)	ver=3.0.1;;
		*)		echo "!!! error: $FUNCNAME() (kde.eclass) called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

	selected_version="$ver"

}

# compat
need-kdelibs() {
    echo "WARNING: need-kdelibs() called, where need-kde() is correct.
If this happens at the unmerging of an old ebuild, disregard; otherwise report."
    need-kde $*
}

# for new schemes
min-kde-ver() {

	debug-print-function $FUNCNAME $*

	case $1 in
	    2*)	selected_version="2.2.2-r2";;
	    3*)	selected_version="3.0";;
	    *)	echo "!!! error: $FUNCNAME() (kde.eclass) called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac
	
}

min-qt-ver() {

	debug-print-function $FUNCNAME $*

	case $1 in
	    2*)	selected_version="2.3.1";;
	    3*)	selected_version="3.0.1";;
	    *)	echo "!!! error: $FUNCNAME() (kde.eclass) called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

}







