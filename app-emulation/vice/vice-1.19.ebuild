# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.19.ebuild,v 1.1 2006/01/17 22:38:32 hanno Exp $

inherit eutils games

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://www.viceteam.org/"
SRC_URI="ftp://ftp.zimmers.net/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X Xaw3d arts esd ffmpeg gnome nls readline sdl"

DEPEND="esd? ( media-sound/esound )
	media-libs/libpng
	sys-libs/zlib
	arts? ( kde-base/arts )
	gnome? ( gnome-base/gnome-libs )
	readline? ( sys-libs/readline )
	sdl? ( media-libs/libsdl )
	X? ( virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )
	ffmpeg? ( media-video/ffmpeg )"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--enable-fullscreen \
		--enable-textfield \
		--enable-ethernet \
		--enable-realdevice \
		--with-resid \
		--without-midas \
		$(use_enable ffmpeg) \
		$(use_enable gnome gnomeui) \
		$(use_enable nls) \
		$(use_with X x) \
		$(use_with Xaw3d xaw3d) \
		$(use_with arts) \
		$(use_with esd) \
		$(use_with readline) \
		$(use_with sdl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog FEEDBACK README
	prepgamesdirs
}
