# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header :$

DESCRIPTION="A hard-disk benchmarking tool."
HOMEPAGE="http://www2.lysator.liu.se/~pen/piozone/"
LICENSE="GPL-2"

DEPEND="sys-devel/gcc"
	   
IUSE=""
SLOT="0"
KEYWORDS="~x86"
S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.lysator.liu.se/pub/unix/${PN}/${P}.tar.gz"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	emake || die
}

src_install() {
	dosbin piozone
}
