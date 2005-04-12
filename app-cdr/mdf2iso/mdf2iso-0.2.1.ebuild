# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mdf2iso/mdf2iso-0.2.1.ebuild,v 1.2 2005/04/12 15:57:05 luckyduck Exp $

inherit gcc

DESCRIPTION="Alcohol 120% bin image to ISO image file converter"
HOMEPAGE="http://mdf2iso.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}-src.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}/${P}-src

src_compile() {
	$(gcc-getCC) src/${PN}.c -o ${PN} ${CFLAGS} || die "compile failed"
}

src_install() {
	dodoc CHANGELOG
	dobin ${PN} || die "dobin failed"
}
