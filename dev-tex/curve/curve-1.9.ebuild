# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/curve/curve-1.9.ebuild,v 1.1 2005/08/02 23:31:01 pylon Exp $

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="LaTeX style for a CV (curriculum vitae) with flavour option"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/curve/"
LICENSE="LPPL-1.2"

IUSE=""
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64"

src_install() {

	latex-package_src_doinstall styles

	dodoc *.tex *.pdf README NEWS

}
