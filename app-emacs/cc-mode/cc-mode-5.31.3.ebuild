# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cc-mode/cc-mode-5.31.3.ebuild,v 1.5 2008/08/28 05:53:00 ulm Exp $

inherit elisp

DESCRIPTION="An Emacs mode for editing C and other languages with similar syntax"
HOMEPAGE="http://cc-mode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_compile() {
	elisp-compile *.el || die "elisp-compile failed"
	makeinfo ${PN}.texi || die "makeinfo failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	dodoc README NEWS
	doinfo ${PN}.info
}
