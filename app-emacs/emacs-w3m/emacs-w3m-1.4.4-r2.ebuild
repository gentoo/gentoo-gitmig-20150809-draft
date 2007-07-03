# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-w3m/emacs-w3m-1.4.4-r2.ebuild,v 1.2 2007/07/03 07:54:50 opfer Exp $

inherit elisp eutils

DESCRIPTION="emacs-w3m is an interface program of w3m on Emacs"
HOMEPAGE="http://emacs-w3m.namazu.org"
SRC_URI="http://emacs-w3m.namazu.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="virtual/w3m"
RDEPEND="${DEPEND}"

SITEFILE=71${PN}-gentoo.el

# This is NOT redundant: elisp.eclass redefines src_compile() from default
src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake lispdir="${D}"/${SITELISP}/${PN} \
		infodir="${D}"/usr/share/info \
		ICONDIR="${D}"/usr/share/pixmaps/${PN} \
		install install-icons || die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog* README*
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see /usr/share/doc/${PF}/README*"
	einfo
	elog "If you want to use the shimbun library, please emerge app-emacs/apel"
	elog "and app-emacs/flim."
	einfo
}

pkg_postrm() {
	elisp-site-regen
}
