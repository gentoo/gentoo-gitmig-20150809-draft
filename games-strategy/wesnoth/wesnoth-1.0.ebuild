# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wesnoth/wesnoth-1.0.ebuild,v 1.1 2005/10/04 14:52:46 mr_bones_ Exp $

inherit eutils toolchain-funcs flag-o-matic games

DESCRIPTION="A fantasy turn-based strategy game"
HOMEPAGE="http://www.wesnoth.org/"
SRC_URI="mirror://sourceforge/wesnoth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="editor gnome kde lite nls server tools"

DEPEND=">=media-libs/libsdl-1.2.7
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/freetype-2
	media-libs/sdl-net
	sys-libs/zlib
	virtual/x11"

src_compile() {
	filter-flags -ftracer -fomit-frame-pointer
	if [[ $(gcc-major-version) -eq 3 ]] ; then
		filter-flags -fstack-protector
	fi
	egamesconf \
		--disable-dependency-tracking \
		--with-localedir=/usr/share/locale \
		$(use_enable lite) \
		$(use_enable server) \
		$(use_enable server campaign-server) \
		$(use_enable editor) \
		$(use_enable tools) \
		$(use_enable nls) \
		$(use_with gnome) \
		$(use_with kde) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	mv "${D}${GAMES_DATADIR}/"{icons,applnk,applications} "${D}/usr/share/"
	if use server ; then
		keepdir "${GAMES_STATEDIR}/run/wesnothd"
	fi
	dodoc MANUAL changelog
	prepgamesdirs
}
