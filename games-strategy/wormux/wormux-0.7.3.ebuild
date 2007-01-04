# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wormux/wormux-0.7.3.ebuild,v 1.7 2007/01/04 23:46:48 nyhm Exp $

inherit eutils games

DESCRIPTION="A free Worms clone"
HOMEPAGE="http://www.wormux.org/"
SRC_URI="http://download.gna.org/wormux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug nls"

RDEPEND=">=media-libs/libsdl-1.2.6
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-ttf-2.0
	media-libs/sdl-net
	>=media-libs/sdl-gfx-2.0.13
	>=dev-cpp/libxmlpp-2.6
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${P}-fix-gettext-Makefile.patch" \
		"${FILESDIR}/${P}-user-CFLAGS.patch" \
		"${FILESDIR}/${P}-fix-tr.po.patch"
	# avoid the strip on install
	sed -i \
		-e "s/@INSTALL_STRIP_PROGRAM@/@INSTALL_PROGRAM@/" \
		src/Makefile.in \
		|| die "sed failed"
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
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
	newicon data/wormux-32.xpm wormux.xpm
	make_desktop_entry wormux Wormux wormux.xpm
	prepgamesdirs
}
