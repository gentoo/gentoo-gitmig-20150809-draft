# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/moon-buggy/moon-buggy-0.5.53.ebuild,v 1.5 2004/02/20 06:13:56 mr_bones_ Exp $

inherit games

DESCRIPTION="A simple console game, where you drive a car across the moon's surface"
HOMEPAGE="http://www.mathematik.uni-kl.de/~wwwstoch/voss/comp/moon-buggy.html"
SRC_URI="http://www.mathematik.uni-kl.de/~wwwstoch/voss/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

RDEPEND=">=sys-libs/ncurses-5"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e '/$(DESTDIR)$(bindir)\/moon-buggy -c/d' Makefile.in || \
			die "sed Makefile.in failed"
}

src_compile() {
	egamesconf sharedstatedir="${GAMES_STATEDIR}" || die
	emake || die "emake failed"
}

src_install() {
	egamesinstall sharedstatedir="${D}${GAMES_STATEDIR}" || die
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README TODO    || die "dodoc failed"
	touch ${D}${GAMES_STATEDIR}/${PN}/mbscore            || die "touch failed"
	fperms 664 ${GAMES_STATEDIR}/${PN}/mbscore           || die "fperms failed"
	prepgamesdirs
}
