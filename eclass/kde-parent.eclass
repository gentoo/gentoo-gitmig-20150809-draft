# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-parent.eclass,v 1.1 2002/05/10 12:07:56 danarmak Exp $
# Inherited by parent ebuilds, which must set their list of $CHILDREN before inheriting
# Make sure to inherit this eclass LAST, for the empty functions below to take effect
ECLASS=kde-parent

# Don't do anything if we're inheriting from a child ebuild
if [ -z "$PARENT" ]; then

	debug-print "$ECLASS: beginning, CHILDREN=$CHILDREN"

	kde-parent_src_unpack() { true; }
	kde-parent_src_compile() { true; }
	kde-parent_src_install() { true; }
	kde-parent_pkg_preinst() { true; }
	kde-parent_pkg_postinst() { true; }
	kde-parent_pkg_prerm() { true; }
	kde-parent_pkg_postrm() { true; }

	RDEPEND="$RDEPEND $CHILDREN"
	
	EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_preinst pkg_postinst pkg_prerm pkg_postrm

else
	debug-print "$ECLASS: \$PARENT set (=$PARENT), child mode assumed, no action taken"
fi
