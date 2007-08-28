# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.72.ebuild,v 1.1 2007/08/28 05:56:01 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa debug hardened opengl"

DEPEND="media-libs/alsa-lib
	opengl? ( virtual/opengl )
	debug? ( sys-libs/ncurses )
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-net
	media-libs/sdl-sound"

pkg_setup() {
	if ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror "To be able to build dosbox with ALSA support you need"
		eerror "to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
	games_pkg_setup
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable !hardened dynamic-x86) \
		$(use_enable debug) \
		$(use_enable opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
	prepgamesdirs
}
