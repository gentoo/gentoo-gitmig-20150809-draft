# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/bookmarksync/bookmarksync-0.3.2.ebuild,v 1.2 2005/07/10 01:21:02 swegener Exp $

IUSE=""

DESCRIPTION="bookmarksync synchronizes various browser bookmark files"
SRC_URI="mirror://sourceforge/booksync/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://sourceforge.net/projects/booksync/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/libc"

src_install () {
	dobin bookmarksync
}
