# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/phylip/phylip-3.61.ebuild,v 1.3 2004/09/29 21:39:58 ribosome Exp $

DESCRIPTION="The PHYLogeny Inference Package"
HOMEPAGE="http://evolution.genetics.washington.edu/${PN}.html"
SRC_URI="ftp://evolution.genetics.washington.edu/pub/${PN}/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"

src_compile() {
	cd src
	mkdir ../fonts
	emake -j1 -e all put || die
	mv ../exe/font* ../fonts
	mv ../doc/phylip.html ../phylip.html
}

src_install() {
	dobin exe/* || die

	dohtml phylip.html
	insinto /usr/share/doc/${PF}/html/doc
	doins doc/*

	insinto /usr/share/${PN}/fonts
	doins fonts/*
}
