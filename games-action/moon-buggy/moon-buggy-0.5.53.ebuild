# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/moon-buggy/moon-buggy-0.5.53.ebuild,v 1.2 2003/10/26 22:26:21 dholm Exp $

inherit games

DESCRIPTION="A simple console game, where you drive a car across the moon's surface"
HOMEPAGE="http://www.mathematik.uni-kl.de/~wwwstoch/voss/comp/moon-buggy.html"
SRC_URI="http://www.mathematik.uni-kl.de/~wwwstoch/voss/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-libs/ncurses-5*
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:$(DESTDIR)$(bindir)/moon-buggy -c:#$(DESTDIR)$(bindir)/moon-buggy -c:' \
		Makefile.in || die "sed Makefile.in failed"
}

src_compile() {
	egamesconf || die
	emake || die
}

src_install() {
	einstall bindir=${D}/${GAMES_BINDIR} || die
	prepgamesdirs
}
