# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/crossfire-server/crossfire-server-1.10.0.ebuild,v 1.1 2007/08/25 23:38:20 tupone Exp $

inherit games

MY_P="${P/-server/}"
DESCRIPTION="server for the crossfire clients"
HOMEPAGE="http://crossfire.real-time.com/"
SRC_URI="mirror://sourceforge/crossfire/${MY_P}.tar.gz
	mirror://sourceforge/crossfire/crossfire-${PV}.maps.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

DEPEND="
	X? (
		x11-libs/libXaw
		media-libs/libpng )"

S=${WORKDIR}/${MY_P}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_with X x) || die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	keepdir "${GAMES_STATEDIR}"/crossfire/{datafiles,maps,players,template-maps,unique-items}
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TODO
	insinto "${GAMES_DATADIR}/crossfire"
	doins -r "${WORKDIR}/maps" || die "doins failed"
	prepgamesdirs
}
