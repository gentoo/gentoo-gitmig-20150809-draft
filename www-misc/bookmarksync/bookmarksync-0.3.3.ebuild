# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/bookmarksync/bookmarksync-0.3.3.ebuild,v 1.3 2007/07/02 14:40:50 peper Exp $

DESCRIPTION="bookmarksync synchronizes various browser bookmark files"
HOMEPAGE="http://sourceforge.net/projects/booksync/"
SRC_URI="mirror://sourceforge/booksync/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE="perl"
RESTRICT="mirror"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	perl? ( dev-lang/perl )"

src_install () {
	dobin bookmarksync
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
