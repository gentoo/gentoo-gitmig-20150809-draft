# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex-beamer/latex-beamer-2.21.ebuild,v 1.4 2005/02/08 11:32:41 usata Exp $

inherit latex-package

DESCRIPTION="LaTeX class for creating presentations using a video projector."
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc ~amd64 ~sparc"

IUSE=""

DEPEND=">=dev-tex/pgf-0.62
	>=dev-tex/xcolor-2.00"
S="${WORKDIR}/beamer"

src_compile() {

	return
}

src_install() {

	dodir /usr/share/texmf/tex/latex/beamer
	cp -a base themes art multimedia \
		${D}/usr/share/texmf/tex/latex/beamer || die

	insinto /usr/share/texmf/tex/latex/beamer/emulation
	doins emulation/*.sty || die

	for dir in examples emulation/examples ; do
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
