# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear/flightgear-0.9.2.ebuild,v 1.1 2003/09/11 12:22:49 vapier Exp $

inherit games

MY_PN=FlightGear
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Source Flight Simulator"
HOMEPAGE="http://www.flightgear.org/"
SRC_URI="mirror://flightgear/Source/${MY_P}.tar.gz
	mirror://flightgear/Shared/fgfs-base-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-games/simgear-0.3.3
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:#include <simgear/screen/jpgfactory.hxx>:#include <simgear/screen/jpgfactory.hxx-faile-include>:g' \
		configure || die "sed configure failed"
}

src_install() {
	egamesinstall || die

	dodir ${GAMES_LIBDIR}/${MY_PN}
	cp -a data/* ${D}/${GAMES_LIBDIR}/${MY_PN}

	dodoc README* ChangeLog AUTHORS NEWS Thanks

	prepgamesdirs
}
