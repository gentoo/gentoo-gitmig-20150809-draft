# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-7.18.ebuild,v 1.8 2004/11/01 03:28:11 weeve Exp $

inherit elisp eutils

DESCRIPTION="An emacs major mode for reading and writing e-mail with support for GPG and MIME."
HOMEPAGE="http://www.wonderworks.com/vm/"
SRC_URI="ftp://ftp.uni-mainz.de/pub/software/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc
	virtual/emacs"

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

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
