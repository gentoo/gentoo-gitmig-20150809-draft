# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/httpd/httpd-0.5.ebuild,v 1.6 2005/01/01 13:48:46 eradicator Exp $

inherit elisp

IUSE=""

DESCRIPTION="A HTTP server embedded in the Emacs"
HOMEPAGE="http://www.chez.com/emarsden/downloads/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

SITEFILE=50httpd-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/httpd.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
