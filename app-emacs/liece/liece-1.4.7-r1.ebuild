# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/liece/liece-1.4.7-r1.ebuild,v 1.3 2004/04/06 03:46:34 vapier Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="Liece is a client implementation of IRC (Internet Relay Chat, RFC 1459)."
HOMEPAGE="http://www.unixuser.org/~ueno/liece/"
SRC_URI="http://www.unixuser.org/~ueno/liece/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	app-emacs/apel"

S="${WORKDIR}/${P}"

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	./configure	--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-lispdir=${SITELISP} \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	make PREFIX=${D}/usr prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		lispdir=${D}/${SITELISP} install || die
	elisp-site-file-install ${FILESDIR}/60liece-gentoo.el
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
