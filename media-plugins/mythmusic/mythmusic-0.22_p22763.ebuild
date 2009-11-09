# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythmusic/mythmusic-0.22_p22763.ebuild,v 1.2 2009/11/09 21:18:03 mr_bones_ Exp $

EAPI=2
inherit qt4 mythtv-plugins

DESCRIPTION="Music player module for MythTV."
IUSE="cdr fftw libvisual opengl sdl"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=media-sound/cdparanoia-3.9.8
	>=media-libs/libcdaudio-0.99.6
	>=media-libs/taglib-1.5
	cdr? ( virtual/cdrtools )
	fftw? ( sci-libs/fftw )
	opengl? ( virtual/opengl )
	sdl? ( >=media-libs/libsdl-1.2.5
		libvisual? ( =media-libs/libvisual-0.4* )
		)"

DEPEND="${RDEPEND}"

pkg_config() {
	if use libvisual && ! use sdl; then
		eerror "libvisual support requires sdl support. enable 'sdl' USE flag"
		die "libvisual support requires sdl support. enable 'sdl' USE flag"
	fi
}

MTVCONF="$(use_enable fftw) $(use_enable sdl) $(use_enable opengl)"
