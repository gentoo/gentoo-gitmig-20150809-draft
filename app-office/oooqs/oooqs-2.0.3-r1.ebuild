# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/oooqs/oooqs-2.0.3-r1.ebuild,v 1.1 2004/08/25 15:00:35 suka Exp $

inherit kde eutils

need-kde 3

DESCRIPTION="OpenOffice.org Quickstarter, runs in the KDE SystemTray"
HOMEPAGE="http://segfaultskde.berlios.de/index.php"
SRC_URI="http://download.berlios.de/segfaultskde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/fixxooo.patch
}

pkg_postinst()
{
	einfo "If upgrading from version 2.0, please remove the oooqs.desktop file from"
	einfo "your "Autostart" directory (linked in the "Goto" menu in Konqueror)."
	einfo
	einfo "If you want to use this for openoffice-ximian and already had it installed"
	einfo "for vanilla openoffice.org before, make sure to delete the old config file in"
	einfo "~/.kde/share/config/oooqsrc"

}
