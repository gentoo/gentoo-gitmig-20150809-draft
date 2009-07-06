# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdump/hdump-1.12.ebuild,v 1.3 2009/07/06 19:01:39 flameeyes Exp $

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
	dobin ${OBJ}/${PN} || die
	doman ${PN}/${PN}.1 || die
}
