# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/xcolor/xcolor-1.09.ebuild,v 1.2 2004/03/10 20:50:03 usata Exp $

inherit latex-package

DESCRIPTION="xcolor -- easy driver-independent access to colors"
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/tetex"
S="${WORKDIR}/${PN}"

src_install() {

	latex-package_src_install || die

	dodoc README
}
