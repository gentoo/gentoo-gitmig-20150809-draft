# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-docbook5-schemas/nxml-docbook5-schemas-20080922.ebuild,v 1.1 2008/09/22 13:09:20 flameeyes Exp $

inherit elisp

DESCRIPTION="Add support for DocBook 5 schemas to NXML"
HOMEPAGE="http://www.docbook.org/schemas/5x.html"
SRC_URI="http://www.docbook.org/xml/5.0/rng/docbookxi.rnc"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( >=app-emacs/nxml-mode-20041004-r3 >=virtual/emacs-23 )"

SITEFILE=60${PN}-gentoo.el

src_compile() { :; }

src_install() {
	insinto ${SITEETC}/${PN}
	doins "${FILESDIR}"/schemas.xml "${DISTDIR}"/docbookxi.rnc || die "install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}

pkg_postinst () {
	elisp-site-regen

	if [ $(emacs -batch -q --eval "(princ (fboundp 'nxml-mode))") = nil ]; then
		ewarn "This package needs nxml-mode. You should either install"
		ewarn "app-emacs/nxml-mode, or use \"eselect emacs\" to select"
		ewarn "an Emacs version >= 23."
	fi
}
