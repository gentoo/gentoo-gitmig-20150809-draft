# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picasm/picasm-1.12b.ebuild,v 1.5 2005/01/01 17:54:54 eradicator Exp $

inherit gcc

MY_PV="${PV//.}"
MY_P="${PN}${MY_PV}"
DESCRIPTION="An assembler and disassembler for 12 and 14-bit PIC chips"
HOMEPAGE="http://www.iki.fi/trossi/pic/"
SRC_URI="http://www.iki.fi/trossi/pic/${MY_P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(gcc-getCC)" || die
}

src_install() {
	dobin picasm || die
	dodoc picasm.txt devices.txt HISTORY TODO
	dohtml picasm.html
	docinto examples
	dodoc examples/*
}
