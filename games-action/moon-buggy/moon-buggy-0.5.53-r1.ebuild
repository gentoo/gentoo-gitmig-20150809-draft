# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/moon-buggy/moon-buggy-0.5.53-r1.ebuild,v 1.2 2004/08/02 23:55:34 vapier Exp $

inherit games

DESCRIPTION="A simple console game, where you drive a car across the moon's surface"
HOMEPAGE="http://www.seehuhn.de/comp/moon-buggy.html"
SRC_URI="http://www.seehuhn.de/data/${P}.tar.gz
	esd? ( http://www.seehuhn.de/data/${PN}-sound-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="esd"

RDEPEND=">=sys-libs/ncurses-5
	esd? ( media-sound/esound )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e '/$(DESTDIR)$(bindir)\/moon-buggy -c/d' \
		Makefile.am || die "sed Makefile.in failed"
	use esd && epatch sound.patch
	rm -f missing
	autoreconf -i || die "autoreconf failed"
}

src_compile() {
	egamesconf --sharedstatedir="${GAMES_STATEDIR}" || die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README* TODO
	touch ${D}${GAMES_STATEDIR}/${PN}/mbscore
	fperms 664 ${GAMES_STATEDIR}/${PN}/mbscore
	prepgamesdirs
}
