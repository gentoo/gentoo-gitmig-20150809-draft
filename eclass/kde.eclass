# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.34 2002/01/10 19:57:41 danarmak Exp $
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.
inherit autoconf base
ECLASS=kde

DESCRIPTION="Based on the $ECLASS eclass"

HOMEPAGE="http://www.kde.org/"

kde_src_compile() {

    debug-print-function $FUNCNAME $*
    [ -z "$1" ] && kde_src_compile all

    while [ "$1" ]; do

	case $1 in
		myconf)
			debug-print-section myconf
			myconf="$myconf --host=${CHOST} --with-x --enable-mitshm --with-xinerama --with-qt-dir=${QTDIR} --with-kde-dir=${KDEDIR}"
			case $KDEMAJORVER in
			    2) myconf="$myconf --prefix=${KDE2DIR}";;
			    3) myconf="$myconf --prefix=${KDE3DIR}";;
			    *) echo "!!! $ECLASS: $FUNCNAME: myconf: could not set --prefix based on \$KDEMAJOVER=\"$KDEMAJORVER\"" && exit 1;;
			esac
			use qtmt 	&& myconf="$myconf --enable-mt"
			[ -n "$DEBUG" ] && myconf="$myconf --enable-debug"	|| myconf="$myconf --disable-debug"
			debug-print "$FUNCNAME: myconf: set to ${myconf}"
			;;
		configure)
			debug-print-section configure
			debug-print "$FUNCNAME::configure: myconf=$myconf"
			
			# This can happen with e.g. a cvs snapshot			
			if [ ! -f "./configure" ]; then
			    for x in Makefile.cvs admin/Makefile.common; do
				if [ -f "$x" ]; then
				    make -f $x
				    break
				fi
			    done
			    [ -f "./configure" ] || die "no configure script found, generation unsuccessful"
			fi

			export PATH="${KDEDIR}/bin:${PATH}"
			./configure ${myconf} || die
			;;
		make)
			export PATH="${KDEDIR}/bin:${PATH}"
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
# because functions from there needed functions from here and vice versa I merged them.

#---------------

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
	    2) export KDEDIR=${KDE2DIR};;
	    3) export KDEDIR=${KDE3DIR};;
	esac
	
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







