# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cc-mode/cc-mode-5.31.3.ebuild,v 1.1 2006/06/18 19:08:51 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="An Emacs mode for editing and C and other languages with similar syntax."
HOMEPAGE="http://cc-mode.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND=""

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp-comp *.el || die
	makeinfo ${PN}.texi || die
}

src_install() {
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc README NEWS
	doinfo ${PN}.info
}
