# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnus/gnus-5.10.2.ebuild,v 1.1 2003/09/10 05:52:29 mkennedy Exp $

inherit elisp

IUSE="emacs-w3"

DESCRIPTION="The Gnus newsreader and mail-reader"
HOMEPAGE="http://www.gnus.org/"
SRC_URI="http://quimby.gnus.org/gnus/dist/gnus-5.10.2.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND="virtual/emacs
	emacs-w3? ( app-emacs/w3 )"

S=${WORKDIR}/${P}

myconf="--with-emacs
	--with-lispdir=${D}/usr/share/emacs/site-lisp/gnus
	--with-etcdir=${D}/usr/share/emacs/etc"

if use emacsw3; then
	myconf="$myconf --with-w3"
else
	myconf="$myconf --without-w3"
fi

src_compile() {
	econf $myconf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ChangeLog GNUS-NEWS README todo
	find ${D}/usr/share/info -type f -exec mv {} {}.info \;
	elisp-site-file-install ${FILESDIR}/70gnus-gentoo.el
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
