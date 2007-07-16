# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdump/hdump-1.12.ebuild,v 1.2 2007/07/16 14:51:27 armin76 Exp $

inherit eutils

DESCRIPTION="A hex \'od\' replacement for UNIX"
HOMEPAGE="http://developer.berlios.de/projects/hdump/"
SRC_URI="mirror://berlios/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND=""

src_compile() {
	make
}

src_install() {
	OBJ=${PN}/OBJ/`ls ${PN}/OBJ`
	dobin ${OBJ}/${PN}
	doman ${PN}/${PN}.1
}
