# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/uptimes/uptimes-2.3.ebuild,v 1.4 2003/09/07 16:04:26 iggy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Track and display emacs session uptimes."
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	app-emacs/boxquote"

S="${WORKDIR}/${P}"

SITEFILE=50uptimes-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/uptimes.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
