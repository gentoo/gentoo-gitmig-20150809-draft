# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/remem/remem-2.11.ebuild,v 1.15 2008/12/30 21:22:36 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="Remembrance Agent plugin for Emacs"
HOMEPAGE="http://www.remem.org/index.html"
SRC_URI="http://www.remem.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="dev-libs/libpcre"

src_compile() {
	tc-export CC RANLIB
	lispdir=/usr/share/emacs/site-lisp econf
	emake -j1 AR="$(tc-getAR)" || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
