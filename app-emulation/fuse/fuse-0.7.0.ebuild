# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fuse/fuse-0.7.0.ebuild,v 1.11 2011/03/27 10:25:00 nirbheek Exp $

EAPI="1"

inherit eutils

DESCRIPTION="Free Unix Spectrum Emulator by Philip Kendall"
HOMEPAGE="http://fuse-emulator.sourceforge.net/"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gtk sdl svga fbcon libdsk xml png"

# This build is heavily use dependent. USE="svga" will build the svga
# version of fuse, otherwise X will be used. Libdsk must be specified
# in order to take advantage of +3 emulation.
RDEPEND="dev-lang/perl
	xml? ( dev-libs/libxml2 )
	png? ( media-libs/libpng )
	~app-emulation/libspectrum-0.2.2
	|| (
		gtk? ( x11-libs/gtk+:2 )
		sdl? ( media-libs/libsdl )
		svga? ( media-libs/svgalib )
		fbcon? ( virtual/linux-sources )
		!svga? ( !fbcon? ( !sdl? (
			x11-libs/libX11
			x11-libs/libXext ) ) )
	)
	dev-libs/glib:2
	libdsk? ( >=app-emulation/libdsk-1.1.5
		app-emulation/lib765 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	local guiflag
	if use gtk; then
		guiflag="--with-x --with-gtk2"
	elif use sdl; then
		guiflag="--without-x --with-sdl"
	elif use svga; then
		guiflag="--without-x --with-svgalib"
	elif use fbcon; then
		guiflag="--without-x --with-fb"
	else
		guiflag="--with-x"
	fi
	econf \
		$(use_with libdsk plus3-disk) \
		--with-glib \
		--without-gtk \
		${guiflag} \
		|| die "econf failed"
		#$(use_with gnome glib) \ -gnome fails, we have to hardcode the glib-dep
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS README THANKS hacking/*.txt
}
