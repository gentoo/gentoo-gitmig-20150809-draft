# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/elph/elph-0.1.4.ebuild,v 1.1 2004/10/30 15:45:52 ribosome Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Estimated Locations of Pattern Hits - Motif finder program"
HOMEPAGE="http://www.tigr.org/software/ELPH/index.shtml"
SRC_URI="ftp://ftp.tigr.org/pub/software/ELPH/ELPH-${PV}.tar.gz"
LICENSE="Artistic"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/ELPH/sources"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-usage.patch
	sed -i -e "s/CC      := g++/CC      := $(tc-getCXX)/" Makefile
	sed -i -e "s/-fno-exceptions -fno-rtti -D_REENTRANT -g/${CXXFLAGS}/" Makefile
	sed -i -e "s/LINKER    := g++/LINKER    := $(tc-getCXX)/" Makefile
}

src_compile() {
	make || die
}

src_install() {
	dobin elph
	cd ${WORKDIR}/ELPH
	dodoc VERSION
	newdoc Readme.ELPH README
}
