# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/virtual.eclass,v 1.4 2001/10/01 13:54:38 danarmak Exp $
# All other eclasses, and thus ebuilds, inherit from this. It defines the EXPORT_FUNCTIONS
# string, which (should) be eval'd by all other eclasses.
inherit debug || die

# Used by the EXPORT_FUNCTIONS code, and placed at the beginning of the eclass
# for elegancy's sake.
# Someday the code that processes an ebuild's name and extracts $PN from it
# can be adapted to automatically calculate $ECLASS from the filename.
# Note that this must come after any inherit lines.
ECLASS=virtual

DESCRIPTION="Based on the $ECLASS eclass."

virtual_src_unpack() {
debug-print-function virtual_src_unpack $*
}
virtual_src_compile() {
debug-print-function virtual_src_compile $*
}
virtual_src_install() {
debug-print-function virtual_src_install $*
}
virtual_pkg_preinst() {
debug-print-function virtual_pkg_preinst $*
}
virtual_pkg_postinst() {
debug-print-function virtual_pkg_postinst $*
}
virtual_pkg_prerm() {
debug-print-function virtual_pkg_prerm $*
}
virtual_pkg_postrm() {
debug-print-function virtual_pkg_postrm $*
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

