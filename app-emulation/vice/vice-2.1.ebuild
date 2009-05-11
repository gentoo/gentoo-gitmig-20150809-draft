# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-2.1.ebuild,v 1.2 2009/05/11 16:46:24 ssuominen Exp $

EAPI=2
inherit eutils games

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://www.viceteam.org/"
SRC_URI="http://www.zimmers.net/anonftp/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="Xaw3d alsa arts esd gnome nls png readline resid sdl ipv6 mmap oss zlib X gif jpeg xv dga xrandr"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXt
	x11-libs/libXxf86vm
	x11-apps/xset
	Xaw3d? ( x11-libs/Xaw3d )
	!Xaw3d? ( !gnome? ( x11-libs/libXaw ) )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	gnome? (
		x11-libs/gtk+:2
		dev-libs/atk
		x11-libs/pango
	)
	nls? ( virtual/libintl )
	png? ( media-libs/libpng )
	readline? ( sys-libs/readline )
	resid? ( media-libs/resid )
	sdl? ( media-libs/libsdl )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	xv? ( x11-libs/libXv )
	dga? ( x11-libs/libXxf86dga )
	xrandr? ( x11-libs/libXrandr )"
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	x11-apps/mkfontdir
	x11-proto/xproto
	x11-proto/xf86vidmodeproto
	x11-proto/xextproto
	dga? ( x11-proto/xf86dgaproto )
	xv? ( x11-proto/videoproto )
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--enable-fullscreen \
		--enable-parsid \
		--disable-ffmpeg \
		--without-midas \
		$(use_enable gnome gnomeui) \
		$(use_enable nls) \
		$(use_with Xaw3d xaw3d) \
		$(use_with alsa) \
		$(use_with arts) \
		$(use_with esd) \
		$(use_with png) \
		$(use_with readline) \
		$(use_with resid) \
		$(use_with sdl) \
		$(use_enable ipv6) \
		$(use_enable oss) \
		$(use_enable mmap memmap) \
		$(use_with zlib) \
		$(use_with X x)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FEEDBACK README
	prepgamesdirs
}
