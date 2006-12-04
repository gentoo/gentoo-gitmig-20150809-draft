# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/elib/elib-1.0.ebuild,v 1.12 2006/12/04 11:53:26 opfer Exp $

inherit elisp

DESCRIPTION="The Emacs Lisp Library"
HOMEPAGE="http://jdee.sunsite.dk/"
SRC_URI="http://jdee.sunsite.dk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos x86"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE=50elib-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:--infodir:--info-dir:g' Makefile
}

src_compile() {
	make || die
}

src_install() {
	dodir ${SITELISP}/elib
	dodir /usr/share/info
	make prefix=${D}/usr infodir=${D}/usr/share/info install || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc ChangeLog INSTALL NEWS README RELEASING TODO
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
