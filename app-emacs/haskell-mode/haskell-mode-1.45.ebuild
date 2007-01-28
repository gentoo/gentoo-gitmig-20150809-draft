# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/haskell-mode/haskell-mode-1.45.ebuild,v 1.2 2007/01/28 04:16:00 genone Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://www.haskell.org/haskell-mode/"
SRC_URI="http://www.haskell.org/haskell-mode/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp_src_install
	dohtml *.html *.hs
}

pkg_postinst() {
	elisp_pkg_postinst
	elog "See /usr/share/doc/${P}/html/installation-guide.html"
}
