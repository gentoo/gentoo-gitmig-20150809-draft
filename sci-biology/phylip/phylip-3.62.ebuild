# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/phylip/phylip-3.62.ebuild,v 1.4 2005/01/14 23:42:22 j4rg0n Exp $

inherit toolchain-funcs

DESCRIPTION="PHYLIP - The PHYLogeny Inference Package"
HOMEPAGE="http://evolution.genetics.washington.edu/phylip.html"
SRC_URI="ftp://evolution.genetics.washington.edu/pub/${PN}/${P}.tar.gz"
LICENSE="freedist"

SLOT="0"
KEYWORDS="x86 ~ppc ppc-macos"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"

S=${WORKDIR}/${P}/src

src_compile() {
	sed -i -e "s/CFLAGS =/CFLAGS = ${CFLAGS}/" Makefile
	sed -i -e "s/CC        = cc/CC        = $(tc-getCC)/" Makefile
	sed -i -e "s/DC        = cc/DC        = $(tc-getCC)/" Makefile
	mkdir ../fonts
	emake -j1 all put || die
	mv ../exe/font* ../fonts
}

src_install()
{
	cd ${WORKDIR}/${P}

	dobin exe/*

	dohtml phylip.html
	insinto /usr/share/doc/${PF}/html/doc
	doins doc/*

	insinto /usr/share/${PN}/fonts
	doins fonts/*
}
