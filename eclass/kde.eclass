# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.26 2001/12/29 17:41:37 danarmak Exp $
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.
inherit autoconf base || die
ECLASS=kde

# for versions with _alpha/_beta etc in them
#S=${WORKDIR}/${P//_}

DESCRIPTION="Based on the $ECLASS eclass"

HOMEPAGE="http://www.kde.org/"

kde_src_compile() {

    debug-print-function $FUNCNAME $*
    [ -z "$1" ] && kde_src_compile all

    while [ "$1" ]; do

	case $1 in
		myconf)
			debug-print-section myconf
			myconf="$myconf --host=${CHOST} --with-x --enable-mitshm --with-xinerama --prefix=/usr --with-qt-dir=${QTDIR}"
			use qtmt 	&& myconf="$myconf --enable-mt"
			[ -n "$DEBUG" ] && myconf="$myconf --enable-debug"	|| myconf="$myconf --disable-debug"
			debug-print "$FUNCNAME: myconf: set to ${myconf}"
			;;
		configure)
			debug-print-section configure
			debug-print "$FUNCNAME::configure: myconf=$myconf"
			./configure ${myconf} || die
			;;
		make)
			debug-print-section make
			make || die
			;;
		all)
			debug-print-section all
			kde_src_compile myconf configure make
			;;
	esac

    shift
    done

}

kde_src_install() {

	debug-print-function $FUNCNAME $*
    [ -z "$1" ] && kde_src_install all

    while [ "$1" ]; do

	case $1 in
	    make)
			debug-print-section make
			make install DESTDIR=${D} destdir=${D} || die
			;;
	    dodoc)
			debug-print-section dodoc
			dodoc AUTHORS ChangeLog README* COPYING NEWS TODO
			;;
	    all)
			debug-print-section all
			kde_src_install make dodoc
			;;
	esac

    shift
    done

}

EXPORT_FUNCTIONS src_compile src_install

# This used to be depend.eclass. At some point I realized it might as well be called kde-depend.eclass. And then
# because functions fom there needed functions from here and vice versa I merged them.

#---------------

need-kde() {

	debug-print-function $FUNCNAME $*
	KDEVER="$1"
	newdepend ">=kde-base/kdelibs-$KDEVER"
	set-kdedir $KDEVER

	qtver-from-kdever $KDEVER
	need-qt $selected_version

}


set-kdedir() {

	debug-print-function $FUNCNAME $*

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

	export KDEDIR="/usr/kde/$KDEMAJORVER"

}

need-qt() {

	debug-print-function $FUNCNAME $*
	QTVER="$1"
	newdepend ">=x11-libs/qt-$QTVER"
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

	local ver

	case $1 in
		2*)	ver=2.3.1;;
		3.0*)	ver=3.0.1;;
		*)		echo "!!! error: qtver-from-kdever() (kde.eclass) called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

	selected_version="$ver"

}














