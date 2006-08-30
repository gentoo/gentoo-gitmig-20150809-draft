# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.19.ebuild,v 1.8 2006/08/30 20:23:43 gustavoz Exp $

inherit eutils games

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://www.viceteam.org/"
SRC_URI="ftp://ftp.zimmers.net/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE="X Xaw3d arts esd ffmpeg gnome nls readline sdl"

XDEPEND="|| (
	(
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXxf86vm
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libXv
			x11-libs/libXxf86dga )
		virtual/x11 )"
RDEPEND="esd? ( media-sound/esound )
	media-libs/libpng
	sys-libs/zlib
	arts? ( kde-base/arts )
	gnome? (
		${XDEPEND}
		gnome-base/gnome-libs )
	readline? ( sys-libs/readline )
	sdl? (
		${XDEPEND}
		|| (
			(
				x11-libs/libXt
				x11-libs/libXmu	)
			virtual/x11 )
		media-libs/libsdl )
	X? (
		${XDEPEND}
		|| (
			(
				x11-libs/libXt
				x11-libs/libXmu
				x11-libs/libXpm
				x11-libs/libXaw	)
			virtual/x11	) )
	Xaw3d? (
		${XDEPEND}
		x11-libs/Xaw3d )
	ffmpeg? ( media-video/ffmpeg )"
DEPEND="${RDEPEND}
	|| (
		(
			x11-proto/xproto
			x11-proto/xf86vidmodeproto
			x11-proto/xextproto
			x11-proto/xf86dgaproto
			x11-proto/videoproto )
		virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-64bitfix.patch
}

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
