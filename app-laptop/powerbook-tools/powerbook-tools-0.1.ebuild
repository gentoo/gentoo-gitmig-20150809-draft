# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/powerbook-tools/powerbook-tools-0.1.ebuild,v 1.4 2004/11/13 15:30:36 hansmi Exp $

KEYWORDS="ppc -mips -x86 -amd64 -alpha -sparc "
IUSE=""
DESCRIPTION="A metapackage to install all the packages needed for good powerbook support"
RDEPEND="app-laptop/pbbuttonsd
	app-laptop/gtkpbbuttons
	app-laptop/pmud
	app-laptop/powerprefs"

LICENSE="GPL-2"

SLOT="0"

src_install() {
	einfo "TO INSTALL DO THE FOLLOWING:"
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
}
