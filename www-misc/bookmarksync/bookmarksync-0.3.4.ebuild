# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/bookmarksync/bookmarksync-0.3.4.ebuild,v 1.2 2004/09/03 16:15:13 pvdabeel Exp $

DESCRIPTION="bookmarksync synchronizes various browser bookmark files"
HOMEPAGE="http://sourceforge.net/projects/booksync/"
SRC_URI="mirror://sourceforge/booksync/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ppc"
SLOT="0"

IUSE="perl"
RESTRICT="nomirror"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	perl? ( dev-lang/perl )"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe bookmarksync
	if use perl >/dev/null; then
		doexe tools/bookmarksync.pl
		dodoc README.tools
	fi
	dodoc README TODO DEVELOPERS
}

pkg_postinst () {
	if use perl >/dev/null; then
		ewarn "You will need to modify bookmarksync.pl before use"
	fi
}
