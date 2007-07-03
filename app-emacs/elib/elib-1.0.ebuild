# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/elib/elib-1.0.ebuild,v 1.13 2007/07/03 09:39:44 opfer Exp $

inherit elisp

DESCRIPTION="The Emacs Lisp Library"
HOMEPAGE="http://jdee.sunsite.dk/"
SRC_URI="http://jdee.sunsite.dk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos x86"
IUSE=""

SITEFILE=50elib-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:--infodir:--info-dir:g' Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir "${SITELISP}/elib"
	dodir /usr/share/info
	emake prefix="${D}/usr" infodir="${D}/usr/share/info" install || die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc ChangeLog INSTALL NEWS README RELEASING TODO
}
