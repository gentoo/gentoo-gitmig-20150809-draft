# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/phylip/phylip-3.63.ebuild,v 1.2 2005/01/02 15:03:40 ribosome Exp $

inherit gcc

DESCRIPTION="PHYLIP - The PHYLogeny Inference Package"
HOMEPAGE="http://evolution.genetics.washington.edu/phylip.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="freedist"

SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc-macos"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"

S=${WORKDIR}/${P}/src

src_compile() {
	sed -i -e "s/CFLAGS =/CFLAGS = ${CFLAGS}/" Makefile
	sed -i -e "s/CC        = cc/CC        = $(gcc-getCC)/" Makefile
	sed -i -e "s/DC        = cc/DC        = $(gcc-getCC)/" Makefile
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
