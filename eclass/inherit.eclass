# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/inherit.eclass,v 1.9 2002/01/04 12:06:28 danarmak Exp $
# This eclass provides the inherit() function. In the future it will be placed in ebuild.sh, but for now drobbins 
# doesn't want to make a new portage just for my testing, so every eclass/ebuild will source this file manually and
# then inherit(). This way when the tmie comes for this to move into stable ebuild.sh, we can just delete the source lines.

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

# this was once virtual.eclass, now merged
# provides empty functions that call debug-print-function and the EXPORT_FUNCTIONS() implementation

inherit debug

ECLASS=virtual

DESCRIPTION="Based on the $ECLASS eclass."

virtual_src_unpack() {
debug-print-function $FUNCNAME $*
}
virtual_src_compile() {
debug-print-function $FUNCNAME $*
}
virtual_src_install() {
debug-print-function $FUNCNAME $*
}
virtual_pkg_preinst() {
debug-print-function $FUNCNAME $*
}
virtual_pkg_postinst() {
debug-print-function $FUNCNAME $*
}
virtual_pkg_prerm() {
debug-print-function $FUNCNAME $*
}
virtual_pkg_postrm() {
debug-print-function $FUNCNAME $*
}

# EXPORT_FUNCTIONS trick
# This is the global part, defined here only.

EXPORT_FUNCTIONS() {

	while [ "$1" ]; do
	    debug-print "EXPORT_FUNCTIONS: ${1} -> ${ECLASS}_${1}" 
	    eval "$1() { ${ECLASS}_$1 ; }" > /dev/null
	shift
	done

}


# This part should be repeated for every eclass inheriting from here.
EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_preinst pkg_postinst pkg_prerm pkg_postrm

