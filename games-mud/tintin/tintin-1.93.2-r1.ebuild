# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tintin/tintin-1.93.2-r1.ebuild,v 1.1 2004/09/08 09:10:01 mr_bones_ Exp $

inherit games

DESCRIPTION="(T)he k(I)cki(N) (T)ickin d(I)kumud clie(N)t"
HOMEPAGE="http://www.scandum.com/tintin/"
SRC_URI="http://www.scandum.com/tintin/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib
	sys-libs/readline
	sys-libs/ncurses"

S="${WORKDIR}/tt/src"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f *.o tt++
}

src_compile() {
	egamesconf || die
	emake CFLAGS="$CFLAGS" || die "emake failed"
}

src_install () {
	dogamesbin tt++ || die "dobin failed"
	dodoc ../{BUGS,CREDITS,FAQ,INSTALL,README,TODO,docs/*}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "**** OLD TINTIN SCRIPTS ARE NOT 100% COMPATIBLE WITH THIS VERSION ****"
	einfo "read the README for more details."
	echo
}
