# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-gentoo-schemas/nxml-gentoo-schemas-20070710.ebuild,v 1.3 2007/08/14 00:45:30 dberkholz Exp $

inherit elisp-common

DESCRIPTION="Extension for nxml-mode with Gentoo-specific schemas"
HOMEPAGE="http://farragut.flameeyes.is-a-geek.org/"

SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="app-emacs/nxml-mode"

SITEFILE=81nxml-gentoo-schemas-gentoo.el

S="${WORKDIR}"

src_unpack() { :; }

src_compile() { :; }

src_install() {
	insinto "${SITELISP}/${PN}"
	doins "${FILESDIR}/schemas.xml" "${FILESDIR}"/*.rnc

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	elisp-site-regen
}
pkg_postrm() {
	elisp-site-regen
}
