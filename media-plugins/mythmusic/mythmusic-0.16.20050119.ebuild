# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythmusic/mythmusic-0.16.20050119.ebuild,v 1.1 2005/01/20 08:20:59 cardoe Exp $

inherit myth flag-o-matic

DESCRIPTION="Music player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -amd64"
IUSE="opengl sdl X nls"

S=${WORKDIR}/mythmusic

DEPEND=">=media-sound/cdparanoia-3.9.8
	>=media-libs/libmad-0.14.2b
	>=media-libs/libid3tag-0.14.2b
	>=media-libs/libvorbis-1.0
	>=media-libs/libcdaudio-0.99.6
	>=media-libs/flac-1.1.0
	>=sys-apps/sed-4
	X? ( =sci-libs/fftw-2* )
	opengl? ( virtual/opengl =sci-libs/fftw-2* )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	|| ( ~media-tv/mythtv-0.16.20050115* ~media-tv/mythfrontend-0.16.20050115* )"

setup_pro() {
	return 0
}

src_unpack() {
	if [ "`gcc-version`" = "3.2" ] || [ "`gcc-version`" = "3.3" ] ; then
		replace-flags mcpu=pentium4 mcpu=pentium3
		replace-flags march=pentium4 march=pentium3
	fi

	myth_src_unpack || die "unpack failed"
}


src_compile() {
	econf \
		`use_enable X fftw` \
		`use_enable opengl` \
		`use_enable sdl`

	myth_src_compile || die "compile failed"
}
