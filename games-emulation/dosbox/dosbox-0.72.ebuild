# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.72.ebuild,v 1.8 2009/01/14 20:25:18 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"
IUSE="alsa debug hardened opengl"

DEPEND="alsa? ( media-libs/alsa-lib[midi] )
	opengl? ( virtual/opengl )
	debug? ( sys-libs/ncurses )
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-net
	media-libs/sdl-sound"

PATCHES=( "${FILESDIR}"/${P}+gcc-4.3.patch )

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable alsa alsa-midi) \
		$(use_enable !hardened dynamic-x86) \
		$(use_enable debug) \
		$(use_enable opengl) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
	prepgamesdirs
}
