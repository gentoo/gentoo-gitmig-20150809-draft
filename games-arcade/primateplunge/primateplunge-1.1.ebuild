# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/primateplunge/primateplunge-1.1.ebuild,v 1.1 2006/03/25 09:44:27 genstef Exp $

inherit eutils games

DESCRIPTION="Help poor Monkey navigate his way down through trecherous areas"
HOMEPAGE="http://www.aelius.com/primateplunge"
SRC_URI="http://www.ecs.soton.ac.uk/~njh/primateplunge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README TIPS

	prepgamesdirs
}
