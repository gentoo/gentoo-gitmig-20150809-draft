# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ognus/ognus-0.24.ebuild,v 1.1 2003/05/02 08:45:00 mkennedy Exp $

inherit elisp 

IUSE=""

DESCRIPTION="Current alpha branch of the Gnus news- and mail-reader"
HOMEPAGE="http://www.gnus.org/"
SRC_URI="http://quimby.gnus.org/gnus/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share \
		--infodir=/usr/share/info \
		--with-emacs \
		--with-lispdir=/usr/share/emacs/site-lisp/ognus \
		--with-etcdir=/usr/share/emacs/etc \
		--with-url=/usr/share/emacs/site-lisp/w3 \
		--with-w3=/usr/share/emacs/site-lisp/w3
	emake || die
}

src_install() {
	make install \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		infodir=${D}/usr/share/info \
		lispdir=${D}/usr/share/emacs/site-lisp/ognus \
		etcdir=${D}/usr/share/emacs/etc \
		|| die

	elisp-site-file-install ${FILESDIR}/70ognus-gentoo.el

	dodoc ChangeLog GNUS-NEWS README todo

	# fix info documentation
	find ${D}/usr/share/info -type f -exec mv {} {}.info \;
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
