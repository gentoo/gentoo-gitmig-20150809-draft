# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/oooqs/oooqs-1.0_rc3.ebuild,v 1.9 2004/07/02 03:07:07 agriffis Exp $

inherit kde eutils
need-kde 3

DESCRIPTION="OpenOffice.org Quickstarter, runs in the KDE SystemTray"
HOMEPAGE="http://segfaultskde.berlios.de/index.php"
SRC_URI="http://download.berlios.de/segfaultskde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/oooqs-debug.patch
}
