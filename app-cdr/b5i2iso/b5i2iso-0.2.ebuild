# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/b5i2iso/b5i2iso-0.2.ebuild,v 1.4 2008/06/06 21:03:24 drac Exp $

inherit toolchain-funcs

DESCRIPTION="BlindWrite image to ISO image file converter"
HOMEPAGE="http://developer.berlios.de/projects/b5i2iso/"
SRC_URI="mirror://berlios/${PN}/${PN}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	$(tc-getCC) src/${PN}.c -o ${PN} ${CFLAGS} || die "compile failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
}
