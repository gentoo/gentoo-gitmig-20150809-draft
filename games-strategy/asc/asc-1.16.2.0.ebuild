# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/asc/asc-1.16.2.0.ebuild,v 1.2 2005/08/24 04:17:57 mr_bones_ Exp $

inherit games

DESCRIPTION="turn based strategy game designed in the tradition of the Battle Isle series"
HOMEPAGE="http://www.asc-hq.org/"
SRC_URI="mirror://sourceforge/asc-hq/asc-source+music-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="app-arch/bzip2
	media-libs/jpeg
	>=media-libs/libsdl-1.2.2
	media-libs/sdl-image
	>=media-libs/sdl-mixer-1.2
	=dev-libs/libsigc++-1.2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# Added --disable-paraguitest for bugs 26402 and 4488
	# Added --disable-paragui for bug 61154 since it's not really used much
	# and the case is well documented at http://www.asc-hq.org/
	egamesconf \
		--disable-dependency-tracking \
		--disable-paraguitest \
		--disable-paragui \
		--datadir="${GAMES_DATADIR_BASE}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	dohtml -r doc/*
	prepgamesdirs
}
