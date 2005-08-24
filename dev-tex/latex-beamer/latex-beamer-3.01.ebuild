# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex-beamer/latex-beamer-3.01.ebuild,v 1.2 2005/08/24 04:02:06 leonardop Exp $

inherit latex-package

DESCRIPTION="LaTeX class for creating presentations using a video projector."
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~amd64 ~sparc"

IUSE=""

DEPEND=">=dev-tex/pgf-0.64
	>=dev-tex/xcolor-2.00"
S="${WORKDIR}/beamer"

src_compile() {

	return
}

src_install() {

	dodir /usr/share/texmf/tex/latex/beamer
	cp -pPR base extensions solutions themes \
		${D}/usr/share/texmf/tex/latex/beamer || die

	insinto /usr/share/texmf/tex/latex/beamer/emulation
	doins emulation/*.sty || die

	for dir in examples emulation/examples ; do
		insinto /usr/share/doc/${PF}/$dir
		doins $dir/*
	done

	if has_version 'app-office/lyx' ; then
		cp -pPR lyx ${D}/usr/share/doc/${PF}
	fi

	dodoc AUTHORS ChangeLog FILES TODO README
	insinto /usr/share/doc/${PF}
	doins doc/*
}
