# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/riece/riece-0.1.7.ebuild,v 1.2 2004/01/28 14:06:03 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="Riece is a redisgn of Liece IRC client"
HOMEPAGE="http://wiliki.designflaw.org/riece.cgi"
SRC_URI="http://wiliki.designflaw.org/riece/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha"

DEPEND="virtual/emacs"

S=${WORKDIR}/${P}
SITEFILE=50riece-gentoo.el

src_compile() {

	econf --with-lispdir=${SITELISP} || die "econf failed"
	emake || die "emake failed"
}

src_install () {

	einstall lispdir=${D}/${SITELISP} || die "einstall failed"
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
