# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear/flightgear-0.9.9.ebuild,v 1.3 2006/10/17 18:06:42 wolf31o2 Exp $

inherit eutils flag-o-matic games

MY_PN=FlightGear
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Open Source Flight Simulator"
HOMEPAGE="http://www.flightgear.org/"
SRC_URI="mirror://flightgear/Source/${MY_P}.tar.gz
	mirror://flightgear/Shared/fgfs-base-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="virtual/glut
	~dev-games/simgear-0.3.9
	>=media-libs/plib-1.8.4
	media-libs/freealut"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ../data ./data
	epatch "${FILESDIR}/${P}"-gcc41.patch
}

src_compile() {
	use hppa && replace-flags -march=2.0 -march=1.0
	egamesconf \
		--with-multiplayer \
		--with-network-olk \
		--with-threads \
		--with-x || die
	emake -j1 || die "emake failed"
}

src_install() {
	egamesinstall || die

	dodir "${GAMES_DATADIR}/${MY_PN}"
	cp -pPR data/* "${D}/${GAMES_DATADIR}/${MY_PN}" || die "cp failed"

	dodoc README* ChangeLog AUTHORS NEWS Thanks

	prepgamesdirs
}
