# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/h4x0r/h4x0r-0.11.ebuild,v 1.7 2005/07/01 18:33:01 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Aid in writing like a script kiddie does"
HOMEPAGE="http://www.livingtorah.org/~csebold/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND="virtual/emacs"

SITEFILE=50h4x0r-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/h4x0r.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
