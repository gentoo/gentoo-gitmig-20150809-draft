# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/bookmarksync/bookmarksync-0.3.1.ebuild,v 1.5 2003/11/23 00:24:27 mholzer Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="bookmarksync synchronizes various browser bookmark files"
SRC_URI="mirror://sourceforge/booksync/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://sourceforge.net/projects/booksync/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/glibc"


src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe bookmarksync
}

