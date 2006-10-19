# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-sound/sdl-sound-1.0.1-r2.ebuild,v 1.7 2006/10/19 17:38:05 flameeyes Exp $

inherit flag-o-matic autotools eutils

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="A library that handles the decoding of sound file formats"
HOMEPAGE="http://icculus.org/SDL_sound/"
SRC_URI="http://icculus.org/SDL_sound/downloads/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="flac mikmod vorbis speex physfs mp3 mpeg"

RDEPEND=">=media-libs/libsdl-1.2
	flac? ( ~media-libs/flac-1.1.2 )
	mikmod? ( >=media-libs/libmikmod-3.1.9 media-libs/libmodplug )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	speex? ( media-libs/speex
		media-libs/libogg )
	physfs? ( dev-games/physfs )
	mpeg? ( media-libs/smpeg )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gcc331.patch
	eautoreconf
}

src_compile() {
	use mikmod \
		&& append-flags $(pkg-config libmodplug --cflags) \
		&& sed -i 's:modplug\.h:libmodplug/modplug.h:' configure
	econf \
		--disable-dependency-tracking \
		--enable-midi \
		$(use_enable mpeg smpeg) \
		$(use_enable mp3 mpglib) \
		$(use_enable flac) \
		$(use_enable speex) \
		$(use_enable mikmod) \
		$(use_enable mikmod modplug) \
		$(use_enable physfs) \
		$(use_enable vorbis ogg) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG CREDITS README TODO
}
