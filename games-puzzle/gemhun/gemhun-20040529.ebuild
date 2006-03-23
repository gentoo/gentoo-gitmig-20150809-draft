# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gemhun/gemhun-20040529.ebuild,v 1.2 2006/03/23 05:16:48 mr_bones_ Exp $

inherit eutils autotools games

DESCRIPTION="A puzzle game about grouping gems of a chosen amount together"
HOMEPAGE="http://gemhun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gemhun/GemHunters-src-${PV}.tar.gz
	mirror://sourceforge/gemhun/fairylands-bin-${PV}.tar.gz
	mirror://sourceforge/gemhun/stars_in_the_night-bin-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="dev-games/kyra
	>=media-libs/sdl-mixer-1.2.1
	virtual/opengl
	sys-libs/ncurses
	media-libs/sdl-net
	media-libs/libpng"

S=${WORKDIR}/GemHunters-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix to comply with gentoo-path
	# and to remove a nasty violation by commenting a network calls
	# Until upstream fix, that is
	epatch "${FILESDIR}/${PV}-gentoo.patch"
	eautoreconf || die "eautoreconf failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README README.Install TODO
	insinto "${GAMES_DATADIR}/GemHunters/pax/"
	doins -r ../fairylands ../stars_in_the_night || die "doins failed"
	doicon pixmaps/${PN}.png
	make_desktop_entry ${PN} "GemHunter" ${PN}.xpm
	prepgamesdirs
}
