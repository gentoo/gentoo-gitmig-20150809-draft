# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cc-mode/cc-mode-5.31.3.ebuild,v 1.3 2007/07/03 09:30:48 opfer Exp $

inherit elisp

DESCRIPTION="An Emacs mode for editing C and other languages with similar syntax"
HOMEPAGE="http://cc-mode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp-comp *.el || die "elisp-comp failed"
	makeinfo ${PN}.texi || die "makeinfo failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc README NEWS
	doinfo ${PN}.info
}
