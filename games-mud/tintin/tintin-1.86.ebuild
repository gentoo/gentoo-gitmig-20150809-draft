# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tintin/tintin-1.86.ebuild,v 1.2 2004/02/20 06:45:14 mr_bones_ Exp $


S=${WORKDIR}/tintin++/src
DESCRIPTION="(T)he k(I)cki(N) (T)ickin d(I)kumud clie(N)t"
SRC_URI="http://mail.newclear.net/tintin/download/tintin++v${PV}.tar.gz"
HOMEPAGE="http://mail.newclear.net/tintin/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
SLOT="0"

DEPEND="sys-libs/ncurses"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake CFLAGS="$CFLAGS" || die
}

src_install () {
	dobin tt++

	dodoc ../BUGS ../CHANGES ../CREDITS ../FAQ ../INSTALL ../README \
		../TODO ../docs/*
}
