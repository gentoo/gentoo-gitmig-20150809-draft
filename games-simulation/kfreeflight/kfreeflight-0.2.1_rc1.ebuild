# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/kfreeflight/kfreeflight-0.2.1_rc1.ebuild,v 1.6 2009/06/25 20:54:50 mr_bones_ Exp $

WANT_AUTOMAKE=1.9 # bug #206412
inherit autotools eutils kde-functions games

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
	egamesconf \
		--without-arts \
		--datadir=/usr/share \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS TODO

	rm -rf "${D}"/usr/share/applnk
	newicon src/hi64-app-kfreeflight.png ${PN}.png
	make_desktop_entry ${PN} KFreeFlight

	prepgamesdirs
}
