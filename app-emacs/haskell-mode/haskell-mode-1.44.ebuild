# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/haskell-mode/haskell-mode-1.44.ebuild,v 1.2 2003/06/29 19:00:22 aliz Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://www.haskell.org/haskell-mode/"
SRC_URI="http://www.haskell.org/haskell-mode/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P}"

SITEFILE=50haskell-mode-gentoo.el

src_compile() {
	 emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dohtml *.html *.hs
}

pkg_postinst() {
	elisp-site-regen
	einfo "See /usr/share/doc/${P}/html/installation-guide.html"
}
                                                                                                               
pkg_postrm() {
	elisp-site-regen
}
