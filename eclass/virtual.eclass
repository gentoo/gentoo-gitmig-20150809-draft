# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/virtual.eclass,v 1.1 2001/09/28 19:25:33 danarmak Exp $
# All other eclasses, and thus ebuilds, inherit from this. It defines the EXPORT_FUNCTIONS
# string, which (should) be eval'd by all other eclasses.

# Used by the EXPORT_FUNCTIONS code, and placed at the beginning of the eclass
# for elegancy's sake.
# Someday the code that processes an ebuild's name and extracts $PN from it
# can be adapted to automatically calculate $ECLASS from the filename.
# Note that this must come after any inherit lines.
ECLASS=virtual

DESCRIPTION="Based on the $ECLASS eclass."

virtual_src_unpack() {
return
}
virtual_src_compile() {
return
}
virtual_src_install() {
return
}
virtual_pkg_preinst() {
return
}
virtual_pkg_postinst() {
return
}
virtual_pkg_prerm() {
return
}
virtual_pkg_postrm() {
return
}

# EXPORT_FUNCTIONS trick
# This is the global part, defined here only.

EXPORT_FUNCTIONS() {

LOCAL_FUNCTIONS="
src_unpack() { ${ECLASS}_src_unpack; }
src_compile() { ${ECLASS}_src_compile; }
src_install() { ${ECLASS}_src_install; }
pkg_preinst() { ${ECLASS}_pkg_preinst; }
pkg_postinst() { ${ECLASS}_pkg_postinst; }
pkg_prerm() { ${ECLASS}_pkg_prerm; }
pkg_postrm() { ${ECLASS}_pkg_postrm; }
"

eval "$LOCAL_FUNCTIONS"
    
}


# This part should be repeated for every eclass inheriting from here.
EXPORT_FUNCTIONS

