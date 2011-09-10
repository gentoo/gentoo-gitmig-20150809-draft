# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yow/yow-21.4_p20020329.ebuild,v 1.8 2011/09/10 10:48:17 ulm Exp $

EAPI=4

inherit elisp

MY_P="emacs-${PV%_p*}"
DESCRIPTION="Zippy the pinhead data base"
HOMEPAGE="http://www.gnu.org/software/emacs/"
SRC_URI="mirror://gnu/emacs/${MY_P}a.tar.gz"

# A slightly different version of yow.lines is also included with
# app-xemacs/cookie, and also with games-misc/fortune-mod which is
# under a BSD licence.
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}/${MY_P}/etc"
ELISP_PATCHES="${PN}-fix-misspellings.patch"
SITEFILE="50${PN}-gentoo.el"

src_compile() { :; }

src_install() {
	insinto "${SITEETC}/${PN}"
	doins yow.lines
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	elisp-site-regen

	elog "To add a menu-bar item for \"yow\" (as it used to be in Emacs 21),"
	elog "add the following lines to your ~/.emacs file:"
	elog
	elog "  (define-key-after menu-bar-games-menu [yow]"
	elog "    '(menu-item \"Random Quotation\" yow"
	elog "                :help \"Display a random Zippy quotation\"))"
}
