# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear/flightgear-0.9.4.ebuild,v 1.3 2004/04/14 23:37:13 mr_bones_ Exp $

inherit games flag-o-matic

MY_PN=FlightGear
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Source Flight Simulator"
HOMEPAGE="http://www.flightgear.org/"
SRC_URI="mirror://flightgear/Source/${MY_P}.tar.gz
	mirror://flightgear/Shared/fgfs-base-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND="=dev-games/simgear-0.3.5*
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
	emake || make || die
}

src_install() {
	egamesinstall || die

	dodir ${GAMES_LIBDIR}/${MY_PN}
	cp -a data/* ${D}/${GAMES_LIBDIR}/${MY_PN}

	dodoc README* ChangeLog AUTHORS NEWS Thanks

	prepgamesdirs
}
