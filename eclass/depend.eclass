# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/depend.eclass,v 1.1 2001/11/16 12:50:41 danarmak Exp $
# This provides the need-kdelibs and need-qt functions, which handle setting KDEDIR
# and QTDIR for the multi-qt and multi-kdelibs schemes. The functions set-kdedir and
# set-qtdir are called from kde.eclass; the need-* functions from the ebuild.

set-kdedir() {

	debug-print-function set-kdedir $*

	biglist="`ls -d1 /usr/lib/kdelibs-*`"
	debug-print "set-kdedir: \$biglist:
${biglist}"

	# filter $biglist to create $list
	list=""
	for x in $biglist; do
	    # strip path, leave version number
	    x="`echo $x | sed -e 's:/usr/lib/kdelibs-::'`"
	    # do comparison
	    if [[ ( $x > $1 ) || ( $x = $1 ) ]]; then
		# add path back on
		list="$list /usr/lib/kdelibs-$x"
	    fi
	done

	debug-print "set-kdedir: filtered \$biglist and got this \$list:
$list"

	# see if we found anything that matches
	if [ -z "$list" ]; then
		debug-print "set-kdedir: WARNING kdelibs dependency version $1 requested, but
no matching installed library has been found. Must be an old system."
	else
		# select last item in sorted list
		for KDEDIR in $list; do true; done
		debug-print "set-kdedir: request for $1 resolved to $KDEDIR"
	fi

}

need-kdelibs() {

	debug-print-function need-kdelibs $*

	if [ -z "$1" ]; then
		kde_version="0"
	else
		kde_version="$1"
	fi

	debug-print "need-kdelibs: version number is $kde_version"

	newdepend ">=kde-base/kdelibs-$kde_version"

}

set-qtdir() {

	debug-print-function set-qtdir $*

	biglist="`ls -d1 /usr/lib/qt-x11-*`"
	debug-print "set-qtdir: \$biglist:
${biglist}"

	# filter $biglist to create $list
	list=""
	for x in $biglist; do
	    # strip path, leave version number
	    x="`echo $x | sed -e 's:/usr/lib/qt-x11-::'`"
	    # do comparison
	    if [[ $x > $1 ]]; then
		list="$list /usr/lib/qt-x11-$x"
	    fi
	done

	debug-print "set-qtdir: filtered \$biglist and got this \$list:
$list"

	# see if we found anything that matches
	if [ -z "$list" ]; then
		debug-print "set-qtdir: WARNING qt dependency version $1 requested, but
no matching installed library has been found. Must be an old system."
	else
		# select last item in sorted list
		for QTDIR in $list; do true; done
		debug-print "set-qtdir: request for $1 resolved to $QTDIR"
	fi

}

need-qt() {

	debug-print-function need-qt $*

	if [ -z "$1" ]; then
		qt_version="0"
	else
		qt_version="$1"
	fi

	debug-print "need-qt: version number is $qt_version"

	newdepend ">=x11-libs/qt-x11-$qt_version"

}

