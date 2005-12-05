# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/oooqs/oooqs-2.0.3-r2.ebuild,v 1.2 2005/12/05 02:13:10 halcy0n Exp $

inherit kde eutils

need-kde 3

DESCRIPTION="OpenOffice.org Quickstarter, runs in the KDE SystemTray"
HOMEPAGE="http://segfaultskde.berlios.de/index.php"
SRC_URI="http://download.berlios.de/segfaultskde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
SLOT="0"

RDEPEND=">=virtual/ooo-2.0.0"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/oooqs-20.patch
}
