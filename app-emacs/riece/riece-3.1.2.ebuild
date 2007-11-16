# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/riece/riece-3.1.2.ebuild,v 1.9 2007/11/16 00:08:22 beandog Exp $

inherit elisp

DESCRIPTION="Riece is a redesign of Liece IRC client"
HOMEPAGE="http://www.nongnu.org/riece/"
SRC_URI="http://savannah.nongnu.org/download/riece/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""
RESTRICT="test"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf --with-lispdir="${SITELISP}" || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall lispdir="${D}/${SITELISP}" || die "einstall failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc AUTHORS NEWS README doc/HACKING lisp/ChangeLog* || die "dodoc failed"
}
