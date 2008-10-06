# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/haskell-mode/haskell-mode-2.4_p20080826.ebuild,v 1.1 2008/10/06 16:10:58 ulm Exp $

inherit elisp

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://www.haskell.org/haskell-mode/
	http://www.iro.umontreal.ca/~monnier/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${PN}"
SITEFILE="51${PN}-gentoo.el"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp_src_install
	dodoc ChangeLog NEWS README
	insinto /usr/share/doc/${PF}
	doins *.hs
}
