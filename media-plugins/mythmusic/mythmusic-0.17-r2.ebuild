# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythmusic/mythmusic-0.17-r2.ebuild,v 1.2 2005/03/27 00:33:23 eradicator Exp $

inherit myth flag-o-matic toolchain-funcs eutils

DESCRIPTION="Music player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mmx opengl sdl X aac"

DEPEND=">=media-sound/cdparanoia-3.9.8
	>=media-libs/libmad-0.15.1b
	>=media-libs/libid3tag-0.15.1b
	>=media-libs/libvorbis-1.0
	>=media-libs/libcdaudio-0.99.6
	>=media-libs/flac-1.1.0
	>=sys-apps/sed-4
	aac? ( media-libs/faad2 )
	X? ( =sci-libs/fftw-2* )
	opengl? ( virtual/opengl =sci-libs/fftw-2* )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	if ! use x86 || ! use mmx; then
		echo "DEFINES -= HAVE_MMX" >> ${S}/settings.pro
	fi
}

src_unpack() {
	if [[ $(gcc-version) = "3.2" || $(gcc-version) == "3.3" ]]; then
		replace-cpu-flags pentium4 pentium3
	fi

	myth_src_unpack || die "unpack failed"

	cd ${S}
	epatch ${FILESDIR}/${P}-sample_rate_type.patch
}

src_compile() {
	econf 	$(use_enable aac) \
		$(use_enable X fftw) \
		$(use_enable opengl) \
		$(use_enable sdl)

	myth_src_compile || die
}
