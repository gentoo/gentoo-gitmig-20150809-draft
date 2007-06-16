# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sml-mode/sml-mode-4.0.ebuild,v 1.3 2007/06/16 19:56:51 ulm Exp $

inherit elisp

DESCRIPTION="Emacs major mode for editing Standard ML"
HOMEPAGE="http://www.iro.umontreal.ca/~monnier/elisp/"
SRC_URI="http://www.iro.umontreal.ca/~monnier/elisp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc-macos ~amd64"
IUSE=""
RESTRICT="test"

SITEFILE=51${PN}-gentoo.el

src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo *.info*
	dodoc BUGS ChangeLog NEWS README TODO
}
