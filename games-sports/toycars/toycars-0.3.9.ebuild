# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/toycars/toycars-0.3.9.ebuild,v 1.1 2009/06/03 20:05:49 ssuominen Exp $

EAPI=2
inherit eutils flag-o-matic games

DESCRIPTION="a physics based 2-D racer inspired by Micro Machines"
HOMEPAGE="http://sourceforge.net/projects/toycars"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	>=media-libs/fmod-4.25.07-r1:1
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}"

src_configure() {
	append-ldflags -L/opt/fmodex/api/lib
	egamesconf
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data || die "doins failed"
	newicon celica-render.png ${PN}.png
	make_desktop_entry ${PN} "Toy Cars"
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
