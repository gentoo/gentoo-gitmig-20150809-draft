# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/sjeng/sjeng-11.2.ebuild,v 1.4 2004/07/14 14:31:22 agriffis Exp $

DESCRIPTION="Console based chess interface"
SRC_URI="mirror://sourceforge/sjeng/Sjeng-Free-${PV}.tar.gz"
HOMEPAGE="http://sjeng.sourceforge.net/"
KEYWORDS="x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	cd ${WORKDIR}/Sjeng-Free-${PV}
	./configure \
		--host=${CHOST} \
		--prefix=/usr
	emake || die
}
src_install () {
	cd ${WORKDIR}/Sjeng-Free-${PV}
	make \
		prefix=${D}/usr \
		install || die
}
