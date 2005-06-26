# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-7.19.ebuild,v 1.7 2005/06/26 18:20:02 blubb Exp $

inherit elisp eutils

DESCRIPTION="An emacs major mode for reading and writing e-mail with support for GPG and MIME."
HOMEPAGE="http://www.wonderworks.com/vm/"
SRC_URI="ftp://ftp.uni-mainz.de/pub/software/gnu/${PN}/${P}.tar.gz
	ftp://ftp.uu.net/networking/mail/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc sparc x86"
IUSE=""

SITEFILE=50vm-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/vm-direntry-fix-gentoo.patch
}

src_compile() {
	make prefix=${D}/usr \
		INFODIR=${D}/usr/share/info \
		LISPDIR=${D}/${SITELISP}/vm \
		PIXMAPDIR=${D}/${SITELISP}/etc/${PN} \
		all || die
}

src_install() {
	make prefix=${D}/usr \
		INFODIR=${D}/usr/share/info \
		LISPDIR=${D}/${SITELISP}/vm \
		PIXMAPDIR=${D}/${SITELISP}/etc/${PN} \
		install || die
	elisp-install ${PN} *.el
	elisp-site-file-install ${FILESDIR}/50vm-gentoo.el
	dodoc README
}
