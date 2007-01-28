# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/bubblet/bubblet-0.74.ebuild,v 1.10 2007/01/28 04:04:15 genone Exp $

inherit elisp

IUSE=""

DESCRIPTION="A bubble-popping game"
HOMEPAGE="http://www.gelatinous.com/pld/bubblet.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="virtual/emacs"

SITEFILE=50bubblet-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see ${SITELISP}/${PN}/bubblet.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
