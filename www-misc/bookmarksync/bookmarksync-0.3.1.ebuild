# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/bookmarksync/bookmarksync-0.3.1.ebuild,v 1.1 2004/08/15 18:03:24 stuart Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="bookmarksync synchronizes various browser bookmark files"
SRC_URI="mirror://sourceforge/booksync/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://sourceforge.net/projects/booksync/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/libc"


src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe bookmarksync
}

