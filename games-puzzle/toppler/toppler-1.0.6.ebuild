# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/toppler/toppler-1.0.6.ebuild,v 1.1 2004/02/09 22:11:14 mr_bones_ Exp $

inherit games

DESCRIPTION="Reimplemention of Nebulous using SDL"
HOMEPAGE="http://toppler.sourceforge.net/"
SRC_URI="mirror://sourceforge/toppler/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

DEPEND=">=media-libs/libsdl-1.2.0
	media-libs/sdl-mixer
	sys-libs/zlib
	nls? ( sys-devel/gettext )"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		`use_enable nls` \
			|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install    || die "make install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
	prepgamesdirs
}
