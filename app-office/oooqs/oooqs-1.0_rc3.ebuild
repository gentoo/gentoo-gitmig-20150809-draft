# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/oooqs/oooqs-1.0_rc3.ebuild,v 1.3 2003/04/17 22:26:31 sethbc Exp $

inherit kde-base 
need-kde 3 

S=${WORKDIR}/${P}

IUSE=""
DESCRIPTION="OpenOffice.org Quickstarter, runs in the KDE SystemTray."
SRC_URI="http://download.berlios.de/segfaultskde/${P}.tar.gz"
HOMEPAGE="http://segfaultskde.berlios.de/index.php"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/oooqs-debug.patch

}
