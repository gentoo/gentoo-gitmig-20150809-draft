# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/bookmarksync/bookmarksync-0.3.4.ebuild,v 1.1 2004/06/23 11:42:08 jmglov Exp $

DESCRIPTION="bookmarksync synchronizes various browser bookmark files"
HOMEPAGE="http://sourceforge.net/projects/booksync/"
SRC_URI="mirror://sourceforge/booksync/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE="perl"
RESTRICT="nomirror"

DEPEND="virtual/glibc"
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
