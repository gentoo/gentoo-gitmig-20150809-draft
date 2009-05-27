# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-gentoo-schemas/nxml-gentoo-schemas-20090527.ebuild,v 1.1 2009/05/27 22:29:08 flameeyes Exp $

inherit elisp

DESCRIPTION="Extension for nxml-mode with Gentoo-specific schemas"
HOMEPAGE="http://blog.flameeyes.eu/"
SRC_URI="http://www.flameeyes.eu/files/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( >=app-emacs/nxml-mode-20041004-r3 >=virtual/emacs-23 )"

SITEFILE=60${PN}-gentoo.el

src_compile() { :; }

src_install() {
	insinto ${SITEETC}/${PN}
	doins schemas.xml *.rnc || die "install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc DONATING
}

pkg_postinst () {
	elisp-site-regen

	if [ $(emacs -batch -q --eval "(princ (fboundp 'nxml-mode))") = nil ]; then
		ewarn "This package needs nxml-mode. You should either install"
		ewarn "app-emacs/nxml-mode, or use \"eselect emacs\" to select"
		ewarn "an Emacs version >= 23."
	fi
}
