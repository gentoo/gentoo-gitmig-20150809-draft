# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-functions.eclass,v 1.32 2002/09/24 17:54:19 danarmak Exp $
# This contains everything except things that modify ebuild variables and functions (e.g. $P, src_compile() etc.)
ECLASS=kde-functions
INHERITED="$INHERITED $ECLASS"
# convinience functions for requesting autotools versions
need-automake() {

    debug-print-function $FUNCNAME $*

    unset WANT_AUTOMAKE_1_4
    unset WANT_AUTOMAKE_1_5
    unset WANT_AUTOMAKE_1_6
    
    case $1 in
	1.4)	export WANT_AUTOMAKE_1_4=1;;
	1.5)	export WANT_AUTOMAKE_1_5=1;;
	1.6)	export WANT_AUTOMAKE_1_6=1;;
	*)	echo "!!! $FUNCNAME: Error: unrecognized automake version $1 requested";;
    esac

}

need-autoconf() {

    debug-print-function $FUNCNAME $*

    unset WANT_AUTOCONF_2_1
    unset WANT_AUTOCONF_2_5
    
    case $1 in
	2.1)	export WANT_AUTOCONF_2_1=1;;
	2.5)	export WANT_AUTOCONF_2_5=1;;
	*)	echo "!!! $FUNCNAME: Error: unrecognized autoconf version $1 requested";;
    esac

}


# ---------------------------------------------------------------
# kde/qt directory management etc. functions, was kde-dirs.ebuild
# ---------------------------------------------------------------

need-kde() {

	debug-print-function $FUNCNAME $*
	KDEVER="$1"

	# determine install locations
	set-kdedir $KDEVER
	
	# if we're a kde-base package, we need an exact version of kdelibs
	# to compile correctly.
	if [ "${INHERITED//kde-dist}" != "$INHERITED" ]; then
	    # kde 3.0.3 and 2.2.2 are special cases, because 3.0.3a and 2.2.2a exist.
	    # goes to show this code is awfully inflexible, i guess.
	    if [ "$PV" == "3.0.3" ]; then
		newdepend "=kde-base/kdelibs-3.0.3*"
	    elif [ "$PV" == "2.2.2" ]; then
		newdepend "=kde-base/kdelibs-2.2.2*"
	    else
		newdepend "~kde-base/kdelibs-${KDEVER}"
	    fi
	elif [ -n "$KDEAPPENDAGE" ]; then
		# special status - installs into $KDEDIR not $PREFIX
		# and needs an exact minor version of kde.
		# this exists for stuff that is part of a kde-base package,
		# but also has older standalone ebuilds which must then go
		# into the older kde's directory and cannot work with the
		# newer kde.
		newdepend "=kde-base/kdelibs-${KDEVER}*"
		export PREFIX="$KDEDIR"
	else
		# everything else only needs a minimum version	
		if [ "$KDEMAJORVER" == "2" ]; then
			newdepend "=kde-base/kdelibs-2.2*"
		else
			min-kde-ver $KDEVER
			newdepend ">=kde-base/kdelibs-${selected_version}"
	    fi
	fi

	qtver-from-kdever $KDEVER
	need-qt $selected_version
	
	if [ -n "$KDEBASE" ]; then
	    SLOT="$KDEMAJORVER.$KDEMINORVER"
	else
	    SLOT="0"
	fi

}

set-kdedir() {

	debug-print-function $FUNCNAME $*

	# is this a kde-base ebuid?
	if [ "${INHERITED//kde-dist}" != "$INHERITED" ] || [ "$PN" == kdelibs ] || [ "$PN" == arts ]; then
		export KDEBASE="true"
	fi

	case "$1" in
	    2*)	
		need-autoconf 2.1
		need-automake 1.4
		;;
	    3.0*)
		if [ -n "$KDEBASE" ]; then
		    # used by 3.0.x kdebase stuff, not by 3rd party apps
		    need-autoconf 2.1
		else
		    need-autoconf 2.5
		fi
		need-automake 1.4
		;;
	    3*)	
		need-autoconf 2.5
		need-automake 1.4
		;;
	    5*)
		need-autoconf 2.5
		need-automake 1.4
		;;
	esac
	
	# set install location:
	# - 3rd party apps go into /usr, and have SLOT="0".
	# - kde-base category ebuilds go into /usr/kde/$MAJORVER.$MINORVER,
	# and have SLOT="$MAJORVER.$MINORVER".
	# - kde-base category cvs ebuilds have major version 5 and go into
	# /usr/kde/cvs; they have SLOT="cvs".
	# - Backward-compatibility exceptions: all kde2 packages (kde-base or otherwise)
	# go into /usr/kde/2. kde 3.0.x goes into /usr/kde/3 (and not 3.0).
	# - kde-base category ebuilds always depend on their exact matching version of
	# kdelibs and link against it. Other ebuilds link aginst the latest one found.
	# - This function exports $PREFIX (location to install to) and $KDEDIR
	# (location of kdelibs to link against) for all ebuilds.
	#
	# -- Overrides - deprecated but working for now: --
	# - If $KDEPREFIX is defined (in the profile or env), it overrides everything
	# and both base and 3rd party kde stuff goes in there.
	# - If $KDELIBSDIR is defined, the kdelibs installed in that location will be
	# used, even by kde-base packages.

	# get version elements
	IFSBACKUP="$IFS"
	IFS=".-_"
	for x in $1; do
		if [ -z "$KDEMAJORVER" ]; then KDEMAJORVER=$x
		else if [ -z "$KDEMINORVER" ]; then KDEMINORVER=$x
		else if [ -z "$KDEREVISION" ]; then KDEREVISION=$x
		fi; fi; fi
	done
	[ -z "$KDEMINORVER" ] && KDEMINORVER="0"
	[ -z "$KDEREVISION" ] && KDEREVISION="0"
	IFS="$IFSBACKUP"
	debug-print "$FUNCNAME: version breakup: KDEMAJORVER=$KDEMAJORVER KDEMINORVER=$KDEMINORVER KDEREVISION=$KDEREVISION"
		
	

	# install prefix
	if [ -n "$KDEPREFIX" ]; then
		export PREFIX="$KDEPREFIX"
	elif [ "$KDEMAJORVER" == "2" ]; then
		export PREFIX="/usr/kde/2"
	else
		if [ -z "$KDEBASE" ]; then
			export PREFIX="/usr"
		else
			case $KDEMAJORVER.$KDEMINORVER in
				3.0) export PREFIX="/usr/kde/3";;
				3.1) export PREFIX="/usr/kde/3.1";;
				3.2) export PREFIX="/usr/kde/3.2";;
				5.0) export PREFIX="/usr/kde/cvs";;
			esac
		fi
	fi
	
	# kdelibs location
	if [ -n "$KDELIBSDIR" ]; then
		export KDEDIR="$KDELIBSDIR"
	elif [ "$KDEMAJORVER" == "2" ]; then
		export KDEDIR="/usr/kde/2"
	else
		if [ -z "$KDEBASE" ]; then
			# find the latest kdelibs installed
			for x in /usr/kde/{cvs,3.2,3.1,3.0,3} $PREFIX $KDE3LIBSDIR $KDELIBSDIR $KDE3DIR $KDEDIR /usr/kde/*; do
				if [ -f "${x}/include/kwin.h" ]; then
					debug-print found
					export KDEDIR="$x"
					break
				fi
			done
		else
			# kde-base ebuilds msut always use the exact version of kdelibs they came with
			case $KDEMAJORVER.$KDEMINORVER in
				3.0) export KDEDIR="/usr/kde/3";;
				3.1) export KDEDIR="/usr/kde/3.1";;
				3.2) export KDEDIR="/usr/kde/3.2";;
				5.0) export KDEDIR="/usr/kde/cvs";;
			esac
		fi
	fi
	

	# check that we've set everything
	[ -z "$PREFIX" ] && debug-print "$FUNCNAME: ERROR: could not set install prefix"
	# it used to be like this. any idea why???
	#[ "${INHERITED//kde-dist}" != "${INHERITED}" -a -z "$KDEDIR" ] && die "$ECLASS: Error: couldn't set kdelibs location, consult log"
	[ -z "$KDEDIR" ] && debug-print "$FUNCNAME: ERROR: couldn't set kdelibs location"

	debug-print "$FUNCNAME: Will use the kdelibs installed in $KDEDIR, and install into $PREFIX."

}

need-qt() {

	debug-print-function $FUNCNAME $*
	QTVER="$1"

	QT=qt

	case $QTVER in
	    2*)	newdepend "=x11-libs/${QT}-2.3*" ;;
	    3*)	newdepend ">=x11-libs/${QT}-3" ;;
	    *)	echo "!!! error: $FUNCNAME() called with invalid parameter: \"$QTVER\", please report bug" && exit 1;;
	esac

	set-qtdir $QTVER

}

set-qtdir() {

	debug-print-function $FUNCNAME $*


	# select 1st element in dot-separated string
	IFSBACKUP=$IFS
	IFS="."
	QTMAJORVER=""
	for x in $1; do
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
		3*)	ver=3.0.4;;
		5)	ver=3.0.4;; # cvs version
		*)	echo "!!! error: $FUNCNAME called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

	selected_version="$ver"

}

# compat
need-kdelibs() {
    echo "WARNING: need-kdelibs() called, where need-kde() is correct.
If this happens at the unmerging of an old ebuild, disregard; otherwise report."
    need-kde $*
}

min-kde-ver() {

	debug-print-function $FUNCNAME $*

	case $1 in
	    2*)		selected_version="2.2.2";;
	    3.0_beta1)	selected_version="3.0_beta1";;
	    3.0_beta2)	selected_version="3.0_beta2";;
	    3.0_rc1)	selected_version="3.0_rc1";;
	    3.0_rc2)	selected_version="3.0_rc2";;
	    3.0_rc3)	selected_version="3.0_rc3";;
	    3.0)	selected_version="3.0";;
	    3.0.*)	selected_version="3.0";;
	    3.1_alpha1)	selected_version="3.1_alpha1";;
	    3.1_beta1)	selected_version="3.1_alpha1";;
	    3.1_beta2)	selected_version="3.1_alpha1";;
	    3.1.*)	selected_version="3.1";;
	    3*)		selected_version="3.0";;
	    5)		selected_version="5";;
	    *)		echo "!!! error: $FUNCNAME() called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac
	
}

# generic makefile sed for sandbox compatibility. for some reason when the kde makefiles (of many packages
# and versions) try to chown root and chmod 4755 some binaries (after installing, target isntall-exec-local),
# they do it to the files in $(bindir), not $(DESTDIR)/$(bindir). Most of these have been fixed in latest cvs
# but a few remain here and there.
# Pass a list of dirs to sed, Makefile.{am,in} in these dirs will be sed'ed.
# This should be harmless if the makefile doesn't need fixing.
kde_sandbox_patch() {

    debug-print-function $FUNCNAME $*
    
    while [ -n "$1" ]; do
	# can't use dosed, because it only works for things in ${D}, not ${S}
	cd $1
	for x in Makefile.am Makefile.in Makefile
	do
	    if [ -f "$x" ]; then
		echo Running sed on $x
		cp $x ${x}.orig
		sed -e 's: $(bindir): $(DESTDIR)/$(bindir):g' -e 's: $(kde_datadir): $(DESTDIR)/$(kde_datadir):g' -e 's: $(TIMID_DIR): $(DESTDIR)/$(TIMID_DIR):g' ${x}.orig > ${x}
		rm ${x}.orig
	    fi
	done
	shift
    done

}


# remove an optimization flag from a specific subdirectory's makefiles.
# currently kdebase and koffice use it to compile certain subdirs without
# -fomit-frame-pointer which breaks some things.
# Parameters:
# $1: subdirectory
# $2: flag to remove
kde_remove_flag() {
    
    debug-print-function $FUNCNAME $*

    cd ${S}/${1} || die
    [ -n "$2" ] || die
    
    cp Makefile Makefile.orig
    sed -e "/CFLAGS/ s/${2}//g
/CXXFLAGS/ s/${2}//g" Makefile.orig > Makefile

    cd $OLDPWD
    
}

# disable a subdir of a module from building.
# used by kdemultimedia et al
# autorun from kde_src_compile:configure if $KDE_REMOVE_DIR is set;
# $KDE_REMOVE_DIR is then passed as parameter
kde_remove_dir(){

    debug-print-function $FUNCNAME $*
    
    cd ${S}
    
    while [ -n "$1" ]; do
	for dir in $1; do
	
	    debug-print "$FUNCNAME: removing subdirectory $dir"
	
	    rm -rf $dir
	    
	    if [ -f subdirs ]; then
		mv subdirs subdirs.orig
		grep -v $dir subdirs.orig > subdirs
	    fi
	    
	    rm -f configure configure.in
	    
	    export DO_NOT_COMPILE="$DO_NOT_COMPILE $dir"
	
	done
	shift
    done

}

