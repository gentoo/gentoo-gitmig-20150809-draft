# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit elisp

IUSE=""

DESCRIPTION="Howm is a note-taking tool on Emacs"
SRC_URI="http://howm.sourceforge.jp/a/${P}.tar.gz"
HOMEPAGE="http://howm.sourceforge.jp/"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/emacs"

SITEFILE="50howm-gentoo.el"

src_compile() {

	econf --with-docdir=/usr/share/doc/${P} || die
	emake < /dev/null || die
}

src_install () {

	emake < /dev/null \
		DESTDIR=${D} PREFIX=/usr LISPDIR=${SITELISP}/${PN} install || die
	elisp-site-file-install ${T}/${SITEFILE} || die
}

pkg_postinst() {
	einfo
	einfo "If you prefer Japanese menu, add the following line to your ~/.emacs"
	einfo
	einfo "(setq howm-menu-lang 'ja)	; Japanese interface"
	einfo

	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
