# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fuse/fuse-0.10.0.2-r1.ebuild,v 1.1 2009/01/29 02:52:21 darkside Exp $

DESCRIPTION="Free Unix Spectrum Emulator by Philip Kendall"
HOMEPAGE="http://fuse-emulator.sourceforge.net"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa ao fbcon gpm gtk joystick libdsk libsamplerate memlimit png sdl svga X xml"

# This build is heavily use dependent. Fuse user interface use flags are, in
# order of precedence: gtk, sdl, X, svga and fbcon. X version of fuse will
# be built if no valid user interface flag is chosen. libdsk flag must be
# specified in order to take advantage of +3 emulation.
RDEPEND="|| (
	gtk? ( >=x11-libs/gtk+-2
		alsa? ( media-libs/alsa-lib )
		ao? ( !alsa? ( media-libs/libao ) )
		joystick? ( media-libs/libjsw ) )
	sdl? ( >=media-libs/libsdl-1.2.4 )
	X? ( x11-libs/libX11
		x11-libs/libXext
		alsa? ( media-libs/alsa-lib )
		ao? ( !alsa? ( media-libs/libao ) )
		joystick? ( media-libs/libjsw ) )
	svga? ( media-libs/svgalib
		alsa? ( media-libs/alsa-lib )
		ao? ( !alsa? ( media-libs/libao ) ) )
	fbcon? ( virtual/linux-sources
		gpm? ( sys-libs/gpm )
		alsa? ( media-libs/alsa-lib )
		ao? ( !alsa? ( media-libs/libao ) )
		joystick? ( media-libs/libjsw ) )
	( x11-libs/libX11
		x11-libs/libXext
		alsa? ( media-libs/alsa-lib )
		ao? ( !alsa? ( media-libs/libao ) )
		joystick? ( media-libs/libjsw ) )
	)
	>=app-emulation/libspectrum-0.5
	libdsk? ( >=app-emulation/libdsk-1.1.5
		app-emulation/lib765 )
	>=dev-libs/glib-2
	png? ( media-libs/libpng )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.0 )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/pkgconfig"

src_compile() {
	local guiflag
	if use gtk; then
		guiflag=""
	elif use sdl; then
		guiflag="--with-sdl"
	elif use X; then
		guiflag="--without-gtk"
	elif use svga; then
		guiflag="--with-svgalib"
	elif use fbcon; then
		guiflag="--with-fb"
	else
		guiflag="--without-gtk"
	fi
	econf --without-win32 \
		${guiflag} \
		$(use_with gpm gpm) \
		$(use_with libdsk plus3-disk) \
		$(use_with alsa alsa) \
		$(use_with ao libao) \
		$(use_with libsamplerate libsamplerate) \
		$(use_with joystick joystick) \
		$(use_enable joystick ui-joystick) \
		$(use_with xml libxml2) \
		$(use_enable memlimit smallmem) \
		|| die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README THANKS
	doman man/fuse.1
}
