# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythmusic/mythmusic-0.21_pre14320.ebuild,v 1.1 2007/08/27 14:47:52 cardoe Exp $

inherit mythtv-plugins flag-o-matic toolchain-funcs eutils subversion

DESCRIPTION="Music player module for MythTV."
IUSE="aac cdr fftw sdl"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=media-sound/cdparanoia-3.9.8
	>=media-libs/libmad-0.15.1b
	>=media-libs/libid3tag-0.15.1b
	>=media-libs/libvorbis-1.0
	>=media-libs/libcdaudio-0.99.6
	>=media-libs/flac-1.1.2
	>=media-libs/taglib-1.4
	aac? ( >=media-libs/faad2-2.0-r7 )
	fftw? ( =sci-libs/fftw-2* )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	cdr? ( virtual/cdrtools )"

DEPEND="${RDEPEND}"

src_unpack() {
	if [[ $(gcc-version) = "3.2" || $(gcc-version) == "3.3" ]]; then
		replace-cpu-flags pentium4 pentium3
	fi

	subversion_src_unpack
	mythtv-plugins_src_unpack_patch || die "unpack failed"
}

MTVCONF="$(use_enable aac) $(use_enable fftw) $(use_enable sdl)"
