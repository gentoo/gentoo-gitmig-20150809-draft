# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/haskell-mode/haskell-mode-1.44-r1.ebuild,v 1.2 2004/03/22 23:55:41 mattam Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://www.haskell.org/haskell-mode/"
SRC_URI="http://www.haskell.org/haskell-mode/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P}"

SITEFILE="50${PN}-gentoo.el"

src_install() {
	elisp_src_install
	dohtml *.html *.hs
}

pkg_postinst() {
	elisp_pkg_postinst
	einfo "See /usr/share/doc/${P}/html/installation-guide.html"
}
