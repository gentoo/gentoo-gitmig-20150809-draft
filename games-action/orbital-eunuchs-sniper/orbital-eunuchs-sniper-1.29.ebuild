# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/orbital-eunuchs-sniper/orbital-eunuchs-sniper-1.29.ebuild,v 1.2 2003/10/25 00:39:11 mr_bones_ Exp $

inherit games

S="${WORKDIR}/orbital_eunuchs_sniper-${PV}"
DESCRIPTION="Snipe terrorists from your orbital base"
HOMEPAGE="http://icculus.org/oes"
SRC_URI="http://filesingularity.timedoctor.org/orbital_eunuchs_sniper-${PV}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=media-libs/libsdl-1.2.5-r1
	>=media-libs/sdl-mixer-1.2.5-r1
	>=media-libs/sdl-image-1.2.2"

src_install() {
	make DESTDIR=${D} install                      || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO readme.txt || die "dodoc failed"
	prepgamesdirs
}
