# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/xcolor/xcolor-2.00-r1.ebuild,v 1.6 2006/02/06 03:10:42 agriffis Exp $

inherit latex-package

DESCRIPTION="xcolor -- easy driver-independent access to colors"
HOMEPAGE="http://www.ukern.de/tex/xcolor.html"
SRC_URI="http://www.ukern.de/tex/xcolor/ctan/${P//[.-]/}.zip"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~ppc-macos ~sparc x86"

IUSE=""

DEPEND="virtual/tetex
	app-arch/unzip
	!>=app-text/tetex-3.0"
RDEPEND="virtual/tetex"
S="${WORKDIR}/${PN}"

src_install() {

	addwrite /var/cache/fonts/

	latex-package_src_install || die

	dodoc README
}
