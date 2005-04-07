# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tintin/tintin-1.93.7.ebuild,v 1.3 2005/04/07 14:45:10 blubb Exp $

inherit games

DESCRIPTION="(T)he k(I)cki(N) (T)ickin d(I)kumud clie(N)t"
HOMEPAGE="http://www.scandum.com/tintin/"
SRC_URI="http://www.scandum.com/tintin/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib
	sys-libs/readline
	sys-libs/ncurses"

S="${WORKDIR}/tt/src"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/^CFLAGS/s/=/+=/' "${S}/Makefile.in" \
		|| die "sed failed"
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
