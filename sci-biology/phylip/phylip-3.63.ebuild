# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/phylip/phylip-3.63.ebuild,v 1.6 2005/02/19 04:29:40 j4rg0n Exp $

inherit toolchain-funcs

DESCRIPTION="PHYLIP - The PHYLogeny Inference Package"
HOMEPAGE="http://evolution.genetics.washington.edu/phylip.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="freedist"

SLOT="0"
KEYWORDS="x86 ~ppc ppc-macos"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"

S=${WORKDIR}/${P}/src

src_compile() {
	sed -e "s/CFLAGS =/CFLAGS = ${CFLAGS}/" \
		-e "s/CC        = cc/CC        = $(tc-getCC)/" \
		-e "s/DC        = cc/DC        = $(tc-getCC)/" \
		-i Makefile || die
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
