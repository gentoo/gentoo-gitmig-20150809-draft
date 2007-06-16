# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.21-r1.ebuild,v 1.1 2007/06/16 16:22:18 nyhm Exp $

inherit eutils games

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://www.viceteam.org/"
SRC_URI="http://www.zimmers.net/anonftp/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="Xaw3d alsa arts esd ffmpeg gnome nls png readline resid sdl"

RDEPEND="media-libs/giflib
	media-libs/jpeg
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXt
	x11-libs/libXv
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	x11-apps/xset
	Xaw3d? ( x11-libs/Xaw3d )
	!Xaw3d? ( x11-libs/libXaw )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	ffmpeg? (
		media-video/ffmpeg
		media-sound/lame
	)
	gnome? ( gnome-base/libgnomeui )
	nls? ( virtual/libintl )
	png? ( media-libs/libpng )
	readline? ( sys-libs/readline )
	resid? ( media-libs/resid )
	sdl? ( media-libs/libsdl )"
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	x11-apps/mkfontdir
	x11-proto/xproto
	x11-proto/xf86vidmodeproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/videoproto
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^gnulocaledir/s:$(prefix):/usr:' \
		po/Makefile.in.in \
		|| die "sed Makefile.in.in failed"
	sed -i \
		-e 's/getline/intlpo_getline/' \
		po/intl2po.c \
		|| die "sed intl2po.c failed"
	sed -i \
		-e 's:\<SYNC\>:OPENGL_SYNC:g' \
		configure src/arch/unix/x11/Makefile.in \
		|| die "sed configure failed"
	epatch "${FILESDIR}"/${P}-uicolor.patch #174056
	epatch "${FILESDIR}"/${P}-fullscreen.patch #179315
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--enable-fullscreen \
		--without-midas \
		$(use_enable ffmpeg) \
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
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FEEDBACK README
	prepgamesdirs
}
