# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/liece/liece-1.4.10-r1.ebuild,v 1.4 2004/04/06 03:46:18 vapier Exp $

inherit elisp eutils

DESCRIPTION="Liece is a client implementation of IRC (Internet Relay Chat, RFC 1459)."
HOMEPAGE="http://www.unixuser.org/~ueno/liece/"
SRC_URI="http://www.unixuser.org/~ueno/liece/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/emacs
	app-emacs/apel"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	econf --with-lispdir=${D}/${SITELISP} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall lispdir=${D}/${SITELISP} || die "einstall failed"
	elisp-site-file-install ${FILESDIR}/60liece-gentoo.el \
		|| die "elisp-site-file-install failed"

	dodoc AUTHORS INSTALL README
}
