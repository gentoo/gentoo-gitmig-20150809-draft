# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-7.19-r3.ebuild,v 1.4 2007/05/10 11:28:07 tove Exp $

inherit elisp eutils

DESCRIPTION="An emacs major mode for reading and writing e-mail with support for GPG and MIME."
HOMEPAGE="http://www.wonderworks.com/vm/"
SRC_URI="ftp://ftp.uni-mainz.de/pub/software/gnu/${PN}/${P}.tar.gz
	ftp://ftp.uu.net/networking/mail/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc sparc x86"
IUSE=""

SITEFILE=51vm-gentoo.el

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/vm-info-dir-fix-gentoo.patch"
	epatch "${FILESDIR}/${P}-burst-digest.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	make prefix="${D}/usr" \
		INFODIR="${D}/usr/share/info" \
		LISPDIR="${D}/${SITELISP}/vm" \
		PIXMAPDIR="${D}/usr/share/pixmaps/vm" \
		all || die
}

src_install() {
	make prefix="${D}/usr" \
		INFODIR="${D}/usr/share/info" \
		LISPDIR="${D}/${SITELISP}/vm" \
		PIXMAPDIR="${D}/usr/share/pixmaps/vm" \
		install || die
	elisp-install ${PN} *.el
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc README
}
