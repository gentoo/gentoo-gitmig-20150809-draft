# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/howm/howm-1.2.ebuild,v 1.3 2004/09/03 01:00:17 dholm Exp $

inherit elisp

DESCRIPTION="note-taking tool on Emacs"
HOMEPAGE="http://howm.sourceforge.jp/"
SRC_URI="http://howm.sourceforge.jp/a/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE="55howm-gentoo.el"

src_compile() {
	econf --with-docdir=/usr/share/doc/${P} || die
	emake < /dev/null || die
}

src_install() {
	emake < /dev/null \
		DESTDIR=${D} PREFIX=/usr LISPDIR=${SITELISP}/${PN} install || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die
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
