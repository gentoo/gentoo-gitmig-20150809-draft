# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/h4x0r/h4x0r-0.11.ebuild,v 1.3 2004/06/01 14:09:04 vapier Exp $

inherit elisp

IUSE=""

DESCRIPTION="Aid in writing like a script kiddie does"
HOMEPAGE="http://www.livingtorah.org/~csebold/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

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
