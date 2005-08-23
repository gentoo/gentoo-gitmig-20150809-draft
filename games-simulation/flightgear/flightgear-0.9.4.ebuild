# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear/flightgear-0.9.4.ebuild,v 1.12 2005/08/23 19:16:38 wolf31o2 Exp $

inherit flag-o-matic games

MY_PN=FlightGear
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Open Source Flight Simulator"
HOMEPAGE="http://www.flightgear.org/"
SRC_URI="mirror://flightgear/Source/${MY_P}.tar.gz
	mirror://flightgear/Shared/fgfs-base-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~amd64"
IUSE=""

RDEPEND="virtual/glut
	=dev-games/simgear-0.3.6*
	>=media-libs/plib-1.7.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:#include <simgear/screen/jpgfactory.hxx>:#include <simgear/screen/jpgfactory.hxx-faile-include>:g' \
		configure || die "sed configure failed"
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

	dodir "${GAMES_LIBDIR}/${MY_PN}"
	cp -pPR data/* "${D}/${GAMES_LIBDIR}/${MY_PN}" || die "cp failed"

	dodoc README* ChangeLog AUTHORS NEWS Thanks

	prepgamesdirs
}
