# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex-beamer/latex-beamer-2.01.ebuild,v 1.1 2004/03/10 20:51:07 usata Exp $

inherit latex-package

DESCRIPTION="LaTeX class for creating presentations using a video projector."
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/tetex
	dev-tex/pgf
	dev-tex/xcolor"
S="${WORKDIR}/beamer"

src_compile() {

	return
}

src_install() {

	dodir /usr/share/texmf/tex/latex/beamer
	cp -a base themes ${D}/usr/share/texmf/tex/latex/beamer

	for dir in examples art ; do
		insinto /usr/share/doc/${PF}/$dir
		doins $dir/*
	done
	if has_version 'app-office/lyx' ; then
		cp -a lyx ${D}/usr/share/doc/${PF}
	fi

	dodoc AUTHORS ChangeLog FILES TODO README
	insinto /usr/share/doc/${PF}
	doins doc/*
}
