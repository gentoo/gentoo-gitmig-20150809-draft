# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/rnaview/rnaview-20040713.ebuild,v 1.1 2005/05/13 01:16:49 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Generates 2D displays of RNA/DNA secondary structures with tertiary interactions"
HOMEPAGE="http://beta-ndb.rutgers.edu/services/download/index.html#rnaview"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s/CC        = cc/CC        = $(tc-getCC)/" \
		-e "s/CFLAGS  =/CFLAGS  = ${CFLAGS}/" \
		-i Makefile || die
}

src_compile() {
	make clean
	make || die
	cd ${S}/rnaml2ps
	make clean
	make || die
	cd ${S}/test
	rm '.#t'
}

src_install() {
	dobin bin/rnaview rnaml2ps/rnaml2ps
	dodoc README
	mkdir -p ${D}/usr/share/${PN}
	cp -r BASEPARS test ${D}/usr/share/${PN}
}
