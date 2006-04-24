# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wormux/wormux-0.7.ebuild,v 1.3 2006/04/24 19:02:24 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A free Worms clone"
HOMEPAGE="http://www.wormux.org/"
SRC_URI="http://download.gna.org/wormux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug nls"

RDEPEND=">=media-libs/libsdl-1.2.6
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-ttf-2.0
	>=media-libs/sdl-gfx-2.0.13
	>=dev-cpp/libxmlpp-2.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${P}-fix-gettext-Makefile.patch" \
		"${FILESDIR}/${P}-user-CFLAGS.patch" \
		"${FILESDIR}/${P}-gcc41.patch"
}

src_compile() {
	egamesconf \
		--with-datadir-name="${GAMES_DATADIR}/${PN}" \
		$(use_enable debug) \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
	newicon data/wormux-32.xpm wormux.xpm
	make_desktop_entry wormux Wormux wormux.xpm
	prepgamesdirs
}
