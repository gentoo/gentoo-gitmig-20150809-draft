# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gtuxnes/gtuxnes-0.75.ebuild,v 1.7 2005/06/15 18:34:47 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="GTK frontend for tuxnes, the emulator for the 8-bit Nintendo Entertainment System"
HOMEPAGE="http://www.scottweber.com/projects/gtuxnes/"
SRC_URI="http://www.scottweber.com/projects/gtuxnes/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}
	>=games-emulation/tuxnes-0.75"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's/gcc/$(CC) $(CFLAGS)/' Makefile \
		|| die 'sed Makefile failed'
	epatch "${FILESDIR}/${PV}-rc.patch"
}

src_install() {
	dogamesbin gtuxnes || die "dogamesbin failed"
	dodoc AUTHORS CHANGES README TODO
	prepgamesdirs
}
