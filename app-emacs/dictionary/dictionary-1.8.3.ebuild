# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/dictionary/dictionary-1.8.3.ebuild,v 1.3 2003/09/08 04:21:55 msterret Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs package for talking to a dictionary server"
HOMEPAGE="http://www.myrkr.in-berlin.de/dictionary/index.html"
SRC_URI="http://www.myrkr.in-berlin.de/dictionary/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

SITEFILE=50dictionary-gentoo.el

src_compile() {
	make EMACS=emacs || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc ChangeLog GPL README
	einfo "Documentation for ${P} can be found at http://www.myrkr.in-berlin.de/dictionary/using.html"
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
