# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/SIunits/SIunits-1.25.ebuild,v 1.9 2004/10/03 21:24:21 swegener Exp $

inherit latex-package
S=${WORKDIR}/SIunits
DESCRIPTION="LaTeX package used to set SI units correct."
SRC_URI="ftp://ftp.dante.de/tex-archive/macros/latex/contrib/supported/SIunits.tar.gz"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/siunits.html"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"
IUSE=""

src_install () {
	latex-package_src_doinstall all
	cd ${S}
	dodoc readme.txt SIunits.pdf
}

