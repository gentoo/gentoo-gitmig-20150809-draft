# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wormux/wormux-0.7.9.ebuild,v 1.1 2007/02/03 15:51:03 nyhm Exp $

inherit eutils games

DESCRIPTION="A free Worms clone"
HOMEPAGE="http://www.wormux.org/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug nls"

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-net
	media-libs/sdl-gfx
	net-misc/curl
	>=dev-cpp/libxmlpp-2.6
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-user-CFLAGS.patch
	sed -i \
		-e '/^xdg_appsdir/s:$(datadir):/usr/share:' \
		data/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-datadir-name="${GAMES_DATADIR}"/${PN} \
		--with-localedir-name=/usr/share/locale \
		$(use_enable debug) \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon data/wormux_128x128.png
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
