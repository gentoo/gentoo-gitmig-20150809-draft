# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/quotchap/quotchap-0.9f.ebuild,v 1.3 2004/11/27 07:24:05 pclouds Exp $

inherit latex-package
S=${WORKDIR}/quotchap
DESCRIPTION="LaTeX package used to add quotes to chapters"
SRC_URI="ftp://ftp.dante.de/tex-archive/macros/latex/contrib/quotchap.tar.gz"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/quotchap.html"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

src_install () {
			addwrite /var/cache/fonts
	        latex-package_src_doinstall all
	        cd ${S}
	        dodoc 00readme.txt document.pdf document.tex
}

