# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnushogi/gnushogi-1.3.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games

DESCRIPTION="Japanese version of chess (commandline + X-Version)"
HOMEPAGE="http://www.gnu.org/directory/games/gnushogi.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X"

DEPEND=">=sys-devel/bison-1.34
	>=sys-devel/flex-2.5
	>=sys-apps/sed-4
	X? ( virtual/x11 )"

src_compile() {
	for f in `grep -Rl -- -ltermcap *` ; do
		sed -i \
			-e 's:-ltermcap:-lcurses:' ${f} || \
				die "sed ${f} failed"
	done

	egamesconf || die
	addpredict /usr/games/lib/gnushogi/gnushogi.hsh
	emake || die "emake failed"
}

src_install() {
	dogamesbin gnushogi/gnushogi
	use X && dogamesbin xshogi/xshogi
	dogameslib gnushogi/gnushogi.bbk
	prepgamesdirs
	dodoc COPYING INSTALL.generic INSTALL README NEWS CONTRIB
}
