# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/inherit.eclass,v 1.10 2002/01/25 17:42:01 danarmak Exp $
# This eclass provides the inherit() function. In the future it will be placed in ebuild.sh, but for now drobbins 
# doesn't want to make a new portage just for my testing, so every eclass/ebuild will source this file manually and
# then inherit(). This way when the time comes for this to move into ebuild.sh, we can just delete the source lines.
ECLASS=inherit

ECLASSDIR=/usr/portage/eclass

inherit() {
    
    while [ "$1" ]; do
	location="${ECLASSDIR}/${1}.eclass"
	# for now, disable by deafult because it creates a lot extra sourcing. (get debug lvels there already!)
	# . ${ECLASSDIR}/debug.eclass
	# debug-print "inherit: $1 -> $location"
	source "$location" || die
    shift
    done

}

inherit virtual debug

