# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-sound/sdl-sound-1.0.1.ebuild,v 1.11 2006/10/19 17:38:05 flameeyes Exp $

inherit eutils

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="A library that handles the decoding of sound file formats"
HOMEPAGE="http://icculus.org/SDL_sound/"
SRC_URI="http://icculus.org/SDL_sound/downloads/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="flac mikmod vorbis speex physfs"

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/smpeg-0.4.4-r1
	flac? ( ~media-libs/flac-1.1.2 )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	speex? ( media-libs/speex
		media-libs/libogg )
	physfs? ( dev-games/physfs )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gcc331.patch
	rm aclocal.m4

	# the patch above plus this overkill ripped off the bootstrap scipt from
	# the sdl_sound CVS to address bug 31163 until the next release.
	aclocal || die "aclocal failed"
	libtoolize --automake --copy --force || die "libtoolize failed"
	autoheader || die "autoheader failed"
	automake --foreign --add-missing --copy || die "automake failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	econf \
		$(use_enable flac) \
		$(use_enable mikmod) \
		$(use_enable vorbis ogg) \
		$(use_enable physfs) \
		$(use_enable speex) \
		--enable-midi \
		|| die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc CHANGELOG CREDITS README TODO
}
