# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/powerbook-tools/powerbook-tools-0.1.ebuild,v 1.7 2003/06/23 00:07:12 rac Exp $

KEYWORDS="ppc -mips -x86 -amd64 -alpha -sparc -arm"
DESCRIPTION="A metapackage to install all the packages needed for good powerbook support"
RDEPEND="sys-apps/pbbuttonsd
	 sys-apps/gtkpbbuttons
	 sys-apps/pmud
         sys-apps/powerprefs"

LICENSE="GPL-2"

SLOT="0"

src_install() {

	einfo "**************************************************************"
	einfo "                 TO INSTALL DO THE FOLLOWING"
	einfo 
	einfo "As root:"
	einfo
	einfo "rc-update add pmud default"
	einfo "rc-update add pbbuttonsd default"
	einfo "/etc/init.d/pmud start"
	einfo "/etc/init.d/pbbuttonsd start"
	einfo
	einfo "As your regular user:"
	einfo 
	einfo "Add gtkpbbuttons to your favorite window managers startup"
	einfo "or to your ~/.xinitrc"
	einfo "**************************************************************"

}
