# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.25.ebuild,v 1.1 2006/12/14 17:50:21 pva Exp $

inherit eutils

DESCRIPTION="The Umiquious Amiga Emulator"
HOMEPAGE="http://www.freiburg.linux.de/~uae/"
SRC_URI="ftp://ftp.freiburg.linux.de/pub/uae/sources/develop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="sdl X dga svga ncurses alsa sdl-sound scsi gtk"

DEPEND="sdl? ( media-libs/libsdl )
	!sdl? ( X? ( x11-libs/libXext
				 x11-libs/libXxf86vm
				 dga? ( x11-libs/libXxf86dga ) )
			!X? ( svga? ( media-libs/svgalib )
				  !svga? ( ncurses? ( sys-libs/ncurses )
				  		   !ncurses? ( media-libs/libsdl ) ) ) )
	alsa? ( media-libs/libsdl )
	!alsa? ( sdl-sound? ( media-libs/alsa-lib ) )
	scsi? ( app-cdr/cdrtools )
	gtk? ( x11-libs/gtk+ )"

pkg_setup() {
	if use sdl ; then
		elog "Enabling sdl for video output."
		my_config="$(use_with sdl) $(use_with sdl sdl-gfx)"
	elif use X ; then
		elog "Enabling X11 for video output."
		my_config="$(use_with X x) $(use_enable X vidmode)"
		use dga? && my_config="${my_config} $(use_enable dga)"
	elif use svga? ; then
		elog "Enabling svga for video output."
		my_config="$(use_with svga svgalib)"
	elif use ncurses? ; then
		elog "Enabling ncurses for video output."
		my_config="$(use_with ncurses asciiart)"
	else
		ewarn "You have not enabled sdl or X or svga or ncruses in USE!"
		ewarn "Video output is not selected. Falling back on sdl..."
		my_config="$(use_with sdl) $(use_with sdl sdl-gfx)"
	fi

	if use alsa ; then
		elog "Enabling alsa for sound output."
		my_config="${my_config} $(use_with alsa)"
	elif use sdl-sound ; then
		elog "Enabling sdl for sound output."
		my_config="${my_config} $(use_with sdl sdl-sound)"
	else
		elog "You have not enabled sdl-sound and alsa in USE!"
		elog "Using sound output to file."
		my_config="${my_config} --enable-file-sound"
	fi

	use gtk && my_config="${my_config} --enable-ui"
	use scsi && my_config="${my_config} --enable-scsi-device"
	my_config="${my_config} --enable-threads"
}


src_compile() {
	econf ${my_config} || die "configure failed"
	emake -j1 || die "emake failed"
}

src_install() {
	dobin uae readdisk || die
	cp docs/unix/README docs/README.unix
	dodoc docs/*

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*}
}
