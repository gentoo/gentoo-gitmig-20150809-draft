# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/eurosym/eurosym-1.2.ebuild,v 1.6 2004/02/21 12:47:58 usata Exp $

inherit latex-package
S=${WORKDIR}/${PN}

DESCRIPTION="LaTeX package and fonts used to set the euro (currency) symbol."
SRC_URI="ftp://ftp.dante.de/tex-archive/fonts/eurosym.tar.gz"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/eurosym.html"
LICENSE="as-is"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc"

SUPPLIER="public"

src_install() {

	dodoc README Changes

	cd ${S}/tfm
	latex-package_src_doinstall all
	cd ${S}/sty
	latex-package_src_doinstall all

	cd ${S}
	insinto ${TEXMF}/fonts/type1/${SUPPLIER}/${PN}
	doins contrib/type1/fonts/type1/eurosym/*
	insinto ${TEXMF}/dvips/config/
	doins contrib/type1/dvips/config/eurosym.map
	insinto ${TEXMF}/fonts/source/${SUPPLIER}/${PN}
	doins src/*.mf

	cd ${S}/doc
	dodoc *

}
