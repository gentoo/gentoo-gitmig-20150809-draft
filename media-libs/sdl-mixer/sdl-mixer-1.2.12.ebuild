# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-mixer/sdl-mixer-1.2.12.ebuild,v 1.4 2012/03/04 05:51:05 mr_bones_ Exp $

EAPI=4
inherit eutils

MY_P=${P/sdl-/SDL_}
DESCRIPTION="Simple Direct Media Layer Mixer Library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_mixer/"
SRC_URI="http://www.libsdl.org/projects/SDL_mixer/release/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="flac fluidsynth mad midi mikmod modplug mp3 playtools static-libs timidity vorbis +wav"
REQUIRED_USE="midi? ( || ( timidity fluidsynth ) )"

DEPEND=">=media-libs/libsdl-1.2.10
	flac? ( media-libs/flac )
	fluidsynth? ( media-sound/fluidsynth )
	timidity? ( media-sound/timidity++ )
	mad? ( media-libs/libmad )
	!mad? ( mp3? ( >=media-libs/smpeg-0.4.4-r1 ) )
	modplug? ( media-libs/libmodplug )
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 media-libs/libogg )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-wav.patch
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-music-flac-shared \
		--disable-music-fluidsynth-shared \
		--disable-music-mod-shared \
		--disable-music-mp3-shared \
		--disable-music-ogg-shared \
		$(use_enable wav music-wave) \
		$(use_enable timidity music-timidity-midi) \
		$(use_enable fluidsynth music-fluidsynth-midi) \
		$(use_enable vorbis music-ogg) \
		$(use_enable mikmod music-mod) \
		$(use_enable modplug music-mod-modplug) \
		$(use_enable flac music-flac) \
		$(use_enable static-libs static) \
		$(use mad && echo --disable-music-mp3 || use_enable mp3 music-mp3) \
		$(use_enable mad music-mp3-mad-gpl)
}

src_install() {
	emake DESTDIR="${D}" install
	if use playtools; then
		emake DESTDIR="${D}" install-bin
	fi
	dodoc CHANGES README
	if ! use static-libs ; then
		find "${D}" -type f -name '*.la' -exec rm {} + \
			|| die "la removal failed"
	fi
}
