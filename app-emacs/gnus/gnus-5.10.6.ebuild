# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnus/gnus-5.10.6.ebuild,v 1.2 2004/01/05 19:12:36 jbms Exp $

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
	local myconf
	if [ $(use emacs-w3) ]; then
		myconf="${myconf} --with-w3=/usr/share/emacs/site-lisp/w3"
		myconf="${myconf} --with-url=/usr/share/emacs/site-lisp/w3"
	else
		myconf="${myconf} --without-w3 --without-url"
	fi
	econf \
		--with-emacs \
		--with-lispdir=/usr/share/emacs/site-lisp/gnus \
		--with-etcdir=/usr/share/emacs/etc \
		${myconf}
	emake || die
}

src_install() {
	einstall \
		lispdir=${D}/usr/share/emacs/site-lisp/gnus \
		etcdir=${D}/usr/share/emacs/etc \
		|| die

	elisp-site-file-install ${FILESDIR}/70${PN}-gentoo.el

	dodoc ChangeLog GNUS-NEWS README todo

	# fix info documentation
	find ${D}/usr/share/info -type f -exec mv {} {}.info \;
}
