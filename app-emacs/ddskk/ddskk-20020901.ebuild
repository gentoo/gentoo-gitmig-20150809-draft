# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ddskk/ddskk-20020901.ebuild,v 1.2 2003/02/13 07:04:28 vapier Exp $

inherit elisp

IUSE=""

DESCRIPTION="SKK is one of Japanese input methods on Emacs"
SRC_URI="http://openlab.ring.gr.jp/skk/maintrunk/${PN}${PV}.tar.gz"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

S=${WORKDIR}/${PN}${PV}

DEPEND="app-emacs/apel
	virtual/emacs
	app-i18n/skk-jisyo"

SITEFILE=50ddskk-gentoo.el

src_compile() {
	patch -p1 < ${FILESDIR}/${PN}-gentoo.patch || die
	emake
	emake info
}

src_install () {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodir /usr/share/skk
	insinto /usr/share/skk
	doins etc/SKK.tut etc/SKK.tut.E etc/NICOLA-SKK.tut etc/skk.xpm

	dodoc READMEs/*

	doinfo doc/skk.info*
}


pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}


