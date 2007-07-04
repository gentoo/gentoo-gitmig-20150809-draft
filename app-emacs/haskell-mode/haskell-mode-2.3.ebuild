# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/haskell-mode/haskell-mode-2.3.ebuild,v 1.4 2007/07/04 23:32:02 opfer Exp $

inherit elisp

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://www.haskell.org/haskell-mode/
	http://www.iro.umontreal.ca/~monnier/elisp/"
SRC_URI="http://www.iro.umontreal.ca/~monnier/elisp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

SITEFILE="51${PN}-gentoo.el"

src_compile(){
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dohtml *.html *.hs
	dodoc ChangeLog NEWS README
	insinto /usr/share/doc/${PF}
	doins *.hs
}
