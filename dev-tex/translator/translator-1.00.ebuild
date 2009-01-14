# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/translator/translator-1.00.ebuild,v 1.9 2009/01/14 18:14:15 jer Exp $

inherit latex-package

DESCRIPTION="A package for translating words in TeX"
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="doc"

TEXMF="/usr/share/texmf-site"

src_install() {
	insinto ${TEXMF}/tex/latex/${PN}
	doins base/* || die "Failed to install the package"
	doins -r dicts/* || die "Failed to install dictonaries"
	dodoc ChangeLog README || die "dodoc failed"
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r doc/* || die "Failed to install documentation"
	fi
}
