# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-w3m/emacs-w3m-1.4.4-r3.ebuild,v 1.1 2009/06/08 19:54:57 ulm Exp $

inherit elisp

DESCRIPTION="emacs-w3m is an interface program of w3m on Emacs"
HOMEPAGE="http://emacs-w3m.namazu.org"
SRC_URI="http://emacs-w3m.namazu.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="linguas_ja"

DEPEND="virtual/w3m"
RDEPEND="${DEPEND}"

SITEFILE="70${PN}-gentoo.el"

src_compile() {
	econf || die "econf failed"
	emake all-en $(useq linguas_ja && echo all-ja) || die "emake failed"
}

src_install() {
	emake lispdir="${D}${SITELISP}/${PN}" \
		infodir="${D}/usr/share/info" \
		ICONDIR="${D}${SITEETC}/${PN}" \
		install-en $(useq linguas_ja && echo install-ja) install-icons \
		|| die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc ChangeLog* README
	use linguas_ja && dodoc README.ja
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
