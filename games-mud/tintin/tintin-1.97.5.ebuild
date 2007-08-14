# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tintin/tintin-1.97.5.ebuild,v 1.1 2007/08/14 03:21:00 mr_bones_ Exp $

inherit games

DESCRIPTION="(T)he k(I)cki(N) (T)ickin d(I)kumud clie(N)t"
HOMEPAGE="http://tintin.sourceforge.net/"
SRC_URI="mirror://sourceforge/tintin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/zlib
	sys-libs/readline
	sys-libs/ncurses"

S=${WORKDIR}/tt/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CC/d' \
		-e '/^MAKE/d' \
		-e '/^CFLAGS/s/=/+=/' Makefile.in \
		|| die "sed failed"
	chmod +x configure
}

src_install () {
	dogamesbin tt++ || die "dogamesbin failed"
	dodoc ../{BUGS,CREDITS,FAQ,README,TODO,docs/*}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "**** OLD TINTIN SCRIPTS ARE NOT 100% COMPATIBLE WITH THIS VERSION ****"
	ewarn "read the README for more details."
	echo
}
