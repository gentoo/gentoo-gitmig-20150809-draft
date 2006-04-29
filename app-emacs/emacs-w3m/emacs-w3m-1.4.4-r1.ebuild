# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-w3m/emacs-w3m-1.4.4-r1.ebuild,v 1.2 2006/04/29 11:59:43 dertobi123 Exp $

inherit elisp eutils

IUSE=""
MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="emacs-w3m is an interface program of w3m on Emacs."
HOMEPAGE="http://emacs-w3m.namazu.org"
SRC_URI="http://emacs-w3m.namazu.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~sparc ~x86"

DEPEND="virtual/w3m"

pkg_setup() {
	if built_with_use www-client/w3m async; then
		eerror "emacs-w3m hangs if you build w3m with async support."
		die "re-emerge www-client/w3m with USE=\"-async\""
	fi
}

src_compile() {
	./configure --prefix=/usr \
		--with-lispdir=${SITELISP}/${PN} \
		--with-icondir=/usr/share/${PN}/icon

	make || die
}

src_install () {
	make lispdir=${D}/${SITELISP}/${PN} \
		infodir=${D}/usr/share/info \
		ICONDIR=${D}/usr/share/${PN}/icon \
		install || die

	make lispdir=${D}/${SITELISP}/${PN} \
		ICONDIR=${D}/usr/share/${PN}/icon \
		install-icons || die

	elisp-site-file-install ${FILESDIR}/70emacs-w3m-gentoo.el

	dodoc ChangeLog* README*
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see /usr/share/doc/${P}/README.gz."
	einfo
	einfo "If you want to use shimbun library, please emerge app-emacs/apel and app-emacs/flim."
	einfo
}

pkg_postrm() {
	elisp-site-regen
}
