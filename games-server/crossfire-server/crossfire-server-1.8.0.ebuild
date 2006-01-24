# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/crossfire-server/crossfire-server-1.8.0.ebuild,v 1.2 2006/01/24 19:41:08 wolf31o2 Exp $

inherit eutils games

MY_P="${P/-server}"
DESCRIPTION="server for the crossfire clients"
HOMEPAGE="http://crossfire.real-time.com/"
SRC_URI="mirror://sourceforge/crossfire/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="X"

DEPEND="virtual/libc
	X? (
		|| (
			(
				x11-libs/libX11
				x11-libs/libXext
				x11-libs/libICE
				x11-libs/libSM
				x11-libs/libXt
				x11-libs/libXmu
				x11-libs/libXaw
				x11-libs/libXpm )
			virtual/x11 )
		media-libs/libpng )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	egamesconf $(use_with X x) || die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	keepdir "${GAMES_STATEDIR}"/crossfire/{datafiles,maps,players,unique-items}
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TODO
	prepgamesdirs
}
