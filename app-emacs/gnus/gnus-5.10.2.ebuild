# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnus/gnus-5.10.2.ebuild,v 1.2 2003/11/08 18:06:59 usata Exp $

inherit elisp

IUSE="emacs-w3"

DESCRIPTION="The Gnus newsreader and mail-reader"
HOMEPAGE="http://www.gnus.org/"
SRC_URI="http://quimby.gnus.org/gnus/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND="virtual/emacs
	emacs-w3? ( app-emacs/w3 )"

S=${WORKDIR}/${P}

src_compile() {
	econf --with-emacs \
		--with-lispdir=${D}/usr/share/emacs/site-lisp/gnus \
		--with-etcdir=${D}/usr/share/emacs/etc \
		`use_with emacs-w3 w3` || die
	emake || die
}

src_install() {
	einstall || die
	elisp-site-file-install ${FILESDIR}/70gnus-gentoo.el

	dodoc ChangeLog GNUS-NEWS README todo
	find ${D}/usr/share/info -type f -exec mv {} {}.info \;
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
