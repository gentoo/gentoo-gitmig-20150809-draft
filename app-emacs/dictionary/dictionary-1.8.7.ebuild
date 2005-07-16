# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/dictionary/dictionary-1.8.7.ebuild,v 1.3 2005/07/16 15:49:37 josejx Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs package for talking to a dictionary server"
HOMEPAGE="http://www.myrkr.in-berlin.de/dictionary/index.html"
SRC_URI="http://www.myrkr.in-berlin.de/dictionary/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	make EMACS=emacs || die
}

src_install() {
	elisp_src_install
	dodoc README
}
