# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wesnoth/wesnoth-0.8.4.ebuild,v 1.2 2004/09/12 21:37:11 mr_bones_ Exp $

inherit eutils flag-o-matic gcc games

DESCRIPTION="A fantasy turn-based strategy game"
HOMEPAGE="http://www.wesnoth.org/"
SRC_URI="mirror://sourceforge/wesnoth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="server editor tools gnome kde nomusic"

DEPEND=">=media-libs/libsdl-1.2.7
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-ttf-2.0
	media-libs/sdl-net
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-conf.patch"
	autoconf -o configure configure.ac
}

src_compile() {
	filter-flags -ftracer
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nomusic lite) \
		$(use_enable server) \
		$(use_enable editor) \
		$(use_enable tools) \
		$(use_with gnome) \
		$(use_with kde) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	mv "${D}${GAMES_DATADIR}/icons" "${D}/usr/share/"
	dodoc MANUAL changelog || die "dodoc failed"
	prepgamesdirs
}
