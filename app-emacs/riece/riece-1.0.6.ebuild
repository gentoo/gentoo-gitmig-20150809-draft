# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/riece/riece-1.0.6.ebuild,v 1.5 2007/05/16 16:52:09 ulm Exp $

inherit elisp

IUSE=""

DESCRIPTION="Riece is a redesign of Liece IRC client"
HOMEPAGE="http://wiliki.designflaw.org/riece.cgi"
SRC_URI="http://wiliki.designflaw.org/riece/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="x86 alpha ppc ~ppc64 ~amd64"

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
