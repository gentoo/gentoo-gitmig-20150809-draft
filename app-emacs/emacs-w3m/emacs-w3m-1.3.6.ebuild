# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-w3m/emacs-w3m-1.3.6.ebuild,v 1.11 2004/10/09 20:12:08 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="emacs-w3m is interface program of w3m on Emacs."
HOMEPAGE="http://emacs-w3m.namazu.org"
SRC_URI="http://emacs-w3m.namazu.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc sparc"

DEPEND="virtual/emacs
	virtual/w3m"

pkg_setup() {
	# use async doesn't ensure you built w3m with async flag,
	# but it's safe to abort if you have it.
	ewarn
	ewarn "emacs-w3m hangs if you build w3m with async support."
	ewarn "Please turn off async USE flag if you set it."
	ewarn
	if use async ; then
		die "async USE flag detected. aborting."
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

	dodoc ChangeLog* README* TIPS* FAQ*
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
