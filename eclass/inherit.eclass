# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/inherit.eclass,v 1.6 2001/10/02 20:23:47 danarmak Exp $
# This eclass provides the inherit() function. In the future it will be placed in ebuild.sh, but for now drobbins 
# doesn't want to make a new portage just for my testing, so every eclass/ebuild will source this file manually and
# then inherit(). This way when the tmie comes for this to move into stable ebuild.sh, we can just delete the source lines.

ECLASSDIR=/usr/portage/eclass

inherit() {
    
    while [ "$1" ]; do
	location="${ECLASSDIR}/${1}.eclass"
	# someday we'll do this the right way.
	# for now, disable by deafult because it creates a lot extra sourcing.
	# . ${ECLASSDIR}/debug.eclass
	debug-print "inherit: $1 -> $location"
	source "$location"
    shift
    done

}
