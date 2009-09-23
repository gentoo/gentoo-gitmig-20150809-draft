# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/bookmarksync/bookmarksync-0.3.4-r1.ebuild,v 1.4 2009/09/23 21:08:04 patrick Exp $

DESCRIPTION="bookmarksync synchronizes various browser bookmark files"
HOMEPAGE="http://sourceforge.net/projects/booksync/"
SRC_URI="mirror://sourceforge/booksync/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="ppc x86"
SLOT="0"

IUSE="perl"
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	perl? ( dev-lang/perl )"

src_install () {
	dobin bookmarksync
	if use perl ; then
		dobin tools/bookmarksync.pl
		dodoc README.tools
	fi
	dodoc README TODO DEVELOPERS
}

pkg_postinst () {
	use perl && ewarn "You will need to modify bookmarksync.pl before use"
}
