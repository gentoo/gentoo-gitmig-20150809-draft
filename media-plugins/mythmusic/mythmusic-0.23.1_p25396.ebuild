# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythmusic/mythmusic-0.23.1_p25396.ebuild,v 1.1 2010/07/27 15:29:08 cardoe Exp $

EAPI=2
inherit qt4 mythtv-plugins

DESCRIPTION="Music player module for MythTV."
IUSE="cdr fftw libvisual opengl sdl"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=media-sound/cdparanoia-3.9.8
	>=media-libs/libcdaudio-0.99.6
	>=media-libs/taglib-1.5
	>=media-libs/flac-1.2.1
	>=media-libs/libogg-1.1.4
	>=media-libs/libvorbis-1.2.1
	cdr? ( virtual/cdrtools )
	fftw? ( sci-libs/fftw )
	opengl? ( virtual/opengl )
	sdl? ( >=media-libs/libsdl-1.2.5
		libvisual? ( =media-libs/libvisual-0.4* )
		)"

DEPEND="${RDEPEND}"

pkg_config() {
	if use libvisual && ! use sdl; then
		ewarn
		ewarn "libvisual support requires sdl support. Enable 'sdl' USE flag"
		ewarn "if you really want libvisual support"
		ewarn
	fi
}

MTVCONF="$(use_enable fftw) $(use_enable sdl) $(use_enable opengl)"
