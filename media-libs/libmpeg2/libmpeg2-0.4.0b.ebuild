# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg2/libmpeg2-0.4.0b.ebuild,v 1.4 2004/04/09 17:45:04 mr_bones_ Exp $

inherit libtool flag-o-matic

MY_P="${P/libmpeg2/mpeg2dec}"
S="${WORKDIR}/${MY_P/b/}"
DESCRIPTION="library for decoding mpeg-2 and mpeg-1 video"
SRC_URI="http://libmpeg2.sourceforge.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://libmpeg2.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="sdl X"

RDEPEND="virtual/glibc
	sdl? ( media-libs/libsdl )
	X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	[ $ARCH = alpha ] && append-flags -fPIC
	unpack ${A}

	# get rid of the -mcpu
	cd ${S}
	sed -i \
		-e 's:OPT_CFLAGS=\"$CFLAGS -mcpu=.*\":OPT_CFLAGS=\"$CFLAGS\":g' \
			configure || die "sed configure failed"
}

src_compile() {
	elibtoolize
	econf \
		--enable-shared \
		--disable-dependency-tracking \
		`use_enable sdl` \
		`use_with X x` \
			|| die
	# builds non-pic library by default? (bug #44934)
	emake LIBMPEG2_CFLAGS= || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
