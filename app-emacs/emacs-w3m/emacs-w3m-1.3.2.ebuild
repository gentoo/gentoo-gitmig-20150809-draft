# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-w3m/emacs-w3m-1.3.2.ebuild,v 1.5 2003/12/15 19:55:00 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="emacs-w3m is interface program of w3m on Emacs."
HOMEPAGE="http://emacs-w3m.namazu.org"
SRC_URI="http://emacs-w3m.namazu.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	virtual/w3m
	>=app-emacs/apel-10.3
	virtual/flim"

S=${WORKDIR}/${P}

src_compile() {
	./configure --prefix=/usr \
		--with-lispdir=${SITELISP}/${PN} \
		--with-icondir=/usr/share/${PN}/icon

	make || die
}

src_install () {
	make lispdir=${D}/${SITELISP}/${PN} \
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
}

pkg_postrm() {
	elisp-site-regen
}
