# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-functions.eclass,v 1.17 2002/07/16 04:40:32 danarmak Exp $
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
	
	# if we're a kde-base package, we need an exact version of kdelibs
	# to compile correctly.
	if [ "${INHERITED//kde-dist}" != "$INHERITED" ]; then
	    newdepend "~kde-base/kdelibs-${KDEVER}"
	    set-kdedir $KDEVER
	else
	    # everyone else only needs a minimum version	
	    set-kdedir $KDEVER
	    
	    if [ "$KDEMAJORVER" == "2" ]; then
		newdepend "=kde-base/kdelibs-2.2*"
	    else
		min-kde-ver $KDEVER
		newdepend ">=kde-base/kdelibs-${selected_version}"
	    fi
	fi

	qtver-from-kdever $KDEVER
	need-qt $selected_version
	
	SLOT="$KDEMAJORVER"

}

set-kdedir() {

	debug-print-function $FUNCNAME $*

	case "$1" in
	    2*)	
	    need-autoconf 2.1
	    need-automake 1.4
	    ;;
	    3*)	
	    need-autoconf 2.5
	    need-automake 1.4
	    ;;
	esac
	
	# get version elements
	IFSBACKUP=$IFS
	IFS=".-_"
	for x in $1; do
		if [ -z "$KDEMAJORVER" ]; then KDEMAJORVER=$x
		else if [ -z "$KDEMINORVER" ]; then KDEMINORVER=$x
		else if [ -z "$KDEREVISION" ]; then KDEREVISION=$x
		fi; fi; fi
	done
	IFS=$IFSBACKUP
	
	# set install location.
	# 3rd party apps go into /usr/kde/$MAJORVER by default
	# a kde version goes into /usr/kde/$MAJORVER.$MINORVER by default
	# and has a SLOT that includes the major and minor version
	# if $KDE3DIR is defined (by the user), it overrides everything
	# and both base and 3rd party kde stuff goes in there, while
	# using the kdelibs (assumedly) present in $KDE3LIBSDIR
	# which equals $KDE3DIR if not set (for kde3, same applies to kde2 with $KDE2DIR etc.)
	# kde.eclass:src_compile:myconf doesn't know about it, we just tell it
	# $KDEDIR (libraries location) and $PREFIX (install location)
	
	case $KDEMAJORVER in
	    2)
		if [ -n "$KDE2DIR" ]; then
		    export PREFIX=${KDE2DIR}
		    export KDEDIR=${KDE2LIBSDIR}
		else
		    export PREFIX=/usr/kde/2
		    # backward compatibility, kde 2.2.2 goes in /usr/kde/2 not /usr/kde/2.2
		    export KDEDIR=/usr/kde/2
		fi
		;;
	    3)
		if [ -n "$KDE3DIR" ]; then
		    # override all other considerations
		    export PREFIX=${KDE3DIR}
		else
		    # base kde part
		    if [ "${INHERITED//kde-dist}" != "${INHERITED}" -o PN=kdelibs -o PN=arts ]; then
			case $KDEMINORVER in
		    	    "")	export PREFIX=/usr/kde/3
				;;
			    0)	export PREFIX=/usr/kde/3
				# kde 3.1 alphas
				[ "$KDEREVISION" -ge 6 ] && export PREFIX=/usr/kde/3.1
				;;
			    1)	export PREFIX=/usr/kde/3.1
				;;
			    2)	export PREFIX=/usr/kde/3.2
				;;
			esac
		    else
			# 3rd party kde app
			export PREFIX=/usr/kde/3
		    fi
		fi
		
		# set kdelibs location
		# KDE3LIBSDIR overrides all considerations
		if [ -n "$KDE3LIBSDIR" ]; then
		    export KDEDIR=${KDE3LIBSDIR}
		else
		    # for kde base, equal to prefix
		    if [ "${INHERITED//kde-dist}" != "$INHERITED" ] || [ "$PN" == kdelibs ] || [ "$PN" == arts ]; then
			debug-print "base package"
			export KDEDIR=$PREFIX
		    else
			# for everything else: try to locate latest version
			# of kdelibs installed. if yours is outside the standard
			# paths, that's what KDE3LIBSDIR is for, use it
			for x in /usr/kde/{cvs,3.2,3.1,3.0,3} $KDEDIR $KDE3DIR $KDE3LIBSDIR /usr/kde/*; do
			    debug-print "checking for $x/include/kwin.h..."
			    if [ -f "${x}/include/kwin.h" ]; then
				debug-print found
				export KDEDIR="$x"
				break
			    fi
			done
		    fi
		fi
		
		;;
	esac

	# check that we've set everything
	[ -z "$PREFIX" ] && die "$ECLASS: Error: could set install prefix, consult log"
	[ "${INHERITED//kde-dist}" != "${INHERITED}" -a -z "$KDEDIR" ] && die "$ECLASS: Error: could set kdelibs location, consult log"

	debug-print "$FUNCNAME: result: KDEDIR=$KDEDIR, PREFIX=$PREFIX"

}

need-qt() {

	debug-print-function $FUNCNAME $*
	QTVER="$1"
	min-qt-ver $QTVER
	newdepend "=x11-libs/qt-$selected_version*"
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
		3*)	ver=3.0.3;;
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
	    3.1.*)	selected_version="3.1";;
	    3*)		selected_version="3.0";;
	    *)		echo "!!! error: $FUNCNAME() called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac
	
}

min-qt-ver() {

	debug-print-function $FUNCNAME $*

	case $1 in
	    2*)	selected_version="2.3";;
	    3*)	selected_version="3";;
	    *)	echo "!!! error: $FUNCNAME() called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

}


# generic makefile sed for sandbox compatibility. for some reason when the kde makefiles (of many packages
# and versions) try to chown root and chmod 4755 some binaries (after installing, target isntall-exec-local),
# they do it to the files in $(bindir), not $(DESTDIR)/$(bindir). I've fild a report on bugs.kde.org but no
# response so far.
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

