# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/xcolor/xcolor-1.11.ebuild,v 1.2 2004/06/25 02:18:00 agriffis Exp $

inherit latex-package

DESCRIPTION="xcolor -- easy driver-independent access to colors"
HOMEPAGE="http://www.ukern.de/tex/xcolor.html"
SRC_URI="http://www.ukern.de/tex/xcolor/ctan/${P//[.-]/}.zip"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

IUSE=""

DEPEND="virtual/tetex"
S="${WORKDIR}/${PN}"

src_install() {

	addwrite /var/cache/fonts/

	latex-package_src_install || die

	dodoc README
}
