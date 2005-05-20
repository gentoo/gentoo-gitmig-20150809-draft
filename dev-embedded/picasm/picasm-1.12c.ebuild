# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picasm/picasm-1.12c.ebuild,v 1.1 2005/05/20 23:48:59 dragonheart Exp $

inherit toolchain-funcs

MY_PV="${PV//.}"
MY_P="${PN}${MY_PV}"
DESCRIPTION="An assembler and disassembler for 12 and 14-bit PIC chips"
HOMEPAGE="http://www.iki.fi/trossi/pic/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
#SRC_URI="http://www.iki.fi/trossi/pic/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-devel/gcc
	dev-lang/perl"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die
}

src_install() {
	dobin picasm || die
	dodoc picasm.txt devices.txt HISTORY TODO
	dohtml picasm.html
	docinto examples
	dodoc examples/*
}
