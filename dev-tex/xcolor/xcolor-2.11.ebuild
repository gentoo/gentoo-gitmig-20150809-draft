# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/xcolor/xcolor-2.11.ebuild,v 1.13 2008/03/15 23:01:14 coldwind Exp $

inherit latex-package

DESCRIPTION="xcolor -- easy driver-independent access to colors"
HOMEPAGE="http://www.ukern.de/tex/xcolor.html"
SRC_URI="http://www.ukern.de/tex/xcolor/ctan/${P//[.-]/}.zip"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE=""

RDEPEND="|| ( dev-texlive/texlive-latex
	>=app-text/tetex-3.0 )"

DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}"

TEXMF="/usr/share/texmf-site"

src_install() {
	export VARTEXFONTS="${T}/fonts"

	latex-package_src_install || die

	dodoc README ChangeLog
}
