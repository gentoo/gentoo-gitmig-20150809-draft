# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crontab-mode/crontab-mode-1.11.ebuild,v 1.7 2005/04/12 13:47:02 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mode for editing crontab files"
HOMEPAGE="http://www.mahalito.net/~harley/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

SITEFILE=50crontab-mode-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/${PN}.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
