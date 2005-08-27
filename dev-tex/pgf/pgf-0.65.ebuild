# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/pgf/pgf-0.65.ebuild,v 1.2 2005/08/27 09:23:12 grobian Exp $

inherit latex-package

DESCRIPTION="pgf -- The TeX Portable Graphic Format"
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~sparc ~x86"

IUSE=""

DEPEND="virtual/tetex
	>=dev-tex/xcolor-2.00"
S="${WORKDIR}/${PN}"

src_compile() {

	return
}

src_install() {

	latex-package_src_install || die

	dodoc AUTHORS ChangeLog FILES README TODO
	insinto /usr/share/doc/${PF}
	doins *.jpg *.pdf *.eps
}
