# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/dictionary/dictionary-1.8.5.ebuild,v 1.1 2003/12/29 00:22:05 jbms Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs package for talking to a dictionary server"
HOMEPAGE="http://www.myrkr.in-berlin.de/dictionary/index.html"
SRC_URI="http://www.myrkr.in-berlin.de/dictionary/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	make EMACS=emacs || die
}

src_install() {
	elisp_src_install
	dodoc README
	einfo "Documentation for ${P} can be found at http://www.myrkr.in-berlin.de/dictionary/using.html"
}
