# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tintin/tintin-1.86.ebuild,v 1.7 2004/07/01 11:21:55 eradicator Exp $

inherit games

S="${WORKDIR}/tintin++/src"
DESCRIPTION="(T)he k(I)cki(N) (T)ickin d(I)kumud clie(N)t"
HOMEPAGE="http://mail.newclear.net/tintin/"
SRC_URI="http://mail.newclear.net/tintin/download/tintin++v${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"
SLOT="0"
IUSE=""

DEPEND="virtual/libc
	sys-libs/readline
	sys-libs/ncurses"

src_compile() {
	egamesconf || die
	emake CFLAGS="$CFLAGS" || die "emake failed"
}

src_install () {
	dogamesbin tt++ || die "dobin failed"
	dodoc ../{BUGS,CHANGES,CREDITS,FAQ,INSTALL,README,TODO,docs/*}
	prepgamesdirs
}
