# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg2/libmpeg2-0.4.0.ebuild,v 1.1 2004/01/03 20:55:22 lu_zero Exp $

IUSE="sdl X"

inherit libtool flag-o-matic

MY_P="${P/libmpeg2/mpeg2dec}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="library for decoding mpeg-2 and mpeg-1 video"
SRC_URI="http://libmpeg2.sourceforge.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://libmpeg2.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="sdl? ( media-libs/libsdl )
	X? ( virtual/x11 )"

[ $ARCH = alpha ] && append-flags -fPIC

src_unpack() {
	unpack ${A}

	# get rid of the -mcpu
	cd ${S} ; cp configure configure.orig
	sed -e 's:OPT_CFLAGS=\"$CFLAGS -mcpu=.*\":OPT_CFLAGS=\"$CFLAGS\":g' \
		configure.orig > configure
}

src_compile() {
	elibtoolize

	local myconf=""

	use sdl \
		&& myconf="${myconf} --enable-sdl" \
		|| myconf="${myconf} --disable-sdl"

	use X && myconf="${myconf} --with-x" \
	      || myconf="${myconf} --without-x"

	econf --enable-shared \
		${myconf} || die "./configure failed"
	emake || make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
