# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-gentoo-schemas/nxml-gentoo-schemas-20071122.ebuild,v 1.1 2007/11/22 15:24:48 flameeyes Exp $

inherit elisp-common

DESCRIPTION="Extension for nxml-mode with Gentoo-specific schemas"
HOMEPAGE="http://farragut.flameeyes.is-a-geek.org/"

SRC_URI="http://flameeyes.is-a-geek.org/files/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="app-emacs/nxml-mode"

SITEFILE=81nxml-gentoo-schemas-gentoo.el

src_compile() { :; }

src_install() {
	insinto "${SITELISP}/${PN}"
	doins schemas.xml *.rnc

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	elisp-site-regen
}
pkg_postrm() {
	elisp-site-regen
}
