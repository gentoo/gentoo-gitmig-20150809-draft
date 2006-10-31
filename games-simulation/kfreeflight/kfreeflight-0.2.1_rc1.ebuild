# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/kfreeflight/kfreeflight-0.2.1_rc1.ebuild,v 1.3 2006/10/31 23:11:41 tupone Exp $

inherit eutils kde games

MY_P=${P//_/}

DESCRIPTION="GUI-Frontend for FlightGear"
HOMEPAGE="http://kfreeflight.sourceforge.net/"
SRC_URI="mirror://sourceforge/kfreeflight/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="games-simulation/flightgear"

S=${WORKDIR}/${PN}-${PV%_*}

need-kde 3.5.2

src_compile() {
	local myconf
	kde_src_compile myconf
	egamesconf $myconf || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS TODO

	rm -rf ${D}/usr/share/applnk
	make_desktop_entry ${PN}

	prepgamesdirs
}
