# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/flim/flim-1.14.7.ebuild,v 1.8 2007/10/06 16:11:53 ulm Exp $

inherit elisp

DESCRIPTION="A library to provide basic features about message representation or encoding"
HOMEPAGE="http://cvs.m17n.org/elisp/FLIM/"
SRC_URI="ftp://ftp.m17n.org/pub/mule/flim/flim-1.14/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="!app-emacs/limit
	>=app-emacs/apel-10.3"

SITEFILE=60${PN}-gentoo.el

src_compile() {
	make PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" || die
}

src_install() {
	make PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" install || die

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	dodoc FLIM-API.en NEWS VERSION README* ChangeLog
}
