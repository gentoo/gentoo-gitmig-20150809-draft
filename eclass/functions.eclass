# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/functions.eclass,v 1.9 2002/03/27 22:33:53 danarmak Exp $
# This contains everything except things that modify ebuild variables and functions (e.g. $P, src_compile() etc.)

# Moved into ebuild.sh in portage-1.8.9_pre32. Here for compatibility with rc6 profiles and 1.8.8 portages.

if [ -z "$COMPAT" ]; then

    einfo "!!! Error: functions.eclass sourced, but compatibility mode not set. This ebuild needs
to be updated, please report."
    exit 1

else
    
    # in case someone really wants the old functions.eclass, get this too, it was a part of it once
    inherit kde-functions
    
    ECLASS=functions

    # ---------------------
    # misc helper functions
    # ---------------------

    # adds all parameters to DEPEND and RDEPEND
    newdepend() {

	debug-print-function newdepend $*
	debug-print "newdepend: DEPEND=$DEPEND RDEPEND=$RDEPEND"

	while [ -n "$1" ]; do
		case $1 in
		    "/autotools")
			    DEPEND="${DEPEND} sys-devel/autoconf sys-devel/automake sys-devel/make"
			    ;;
		    "/c")
			    DEPEND="${DEPEND} sys-devel/gcc virtual/glibc sys-devel/ld.so"
			    RDEPEND="${RDEPEND} virtual/glibc sys-devel/ld.so"
			    ;;
		    *)
			    DEPEND="$DEPEND $1"
			    RDEPEND="$RDEPEND $1"
			    ;;
		esac
		shift
	done

}

fi
