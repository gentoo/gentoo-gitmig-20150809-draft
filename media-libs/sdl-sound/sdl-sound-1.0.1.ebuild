# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-sound/sdl-sound-1.0.1.ebuild,v 1.2 2003/10/15 04:36:25 mr_bones_ Exp $

MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library that handles the decoding of sound file formats"
SRC_URI="http://icculus.org/SDL_sound/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://icculus.org/SDL_sound/"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/smpeg-0.4.4-r1
	flac? ( media-libs/flac )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

IUSE="flac mikmod oggvorbis"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gcc331.patch
	rm aclocal.m4
}

src_compile() {
	# the patch above plus this overkill ripped off the bootstrap scipt from
	# the sdl_sound CVS to address bug 31163 until the next release.
	aclocal
	libtoolize --automake --copy --force
	autoheader
	automake --foreign --add-missing --copy
	autoconf

	econf \
		`use_enable flac` \
		`use_enable mikmod` \
		`use_enable oggvorbis ogg` \
		--enable-midi || die

	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc CHANGELOG CREDITS INSTALL README TODO || die "dodoc failed"
}
