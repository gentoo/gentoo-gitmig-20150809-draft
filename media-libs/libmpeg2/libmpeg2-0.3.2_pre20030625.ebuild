# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg2/libmpeg2-0.3.2_pre20030625.ebuild,v 1.4 2004/03/19 07:56:04 mr_bones_ Exp $

IUSE="sdl X"

inherit libtool flag-o-matic

S="${WORKDIR}/mpeg2dec-0.3.2-cvs"
DESCRIPTION="library for decoding mpeg-2 and mpeg-1 video"
SRC_URI="mirror://gentoo/mpeg2dec-cvs-20030625.tar.gz"
HOMEPAGE="http://libmpeg2.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha amd64"

DEPEND="sdl? ( media-libs/libsdl )
	X? ( virtual/x11 )"

# this build doesn't play nice with -maltivec (gcc 3.2 only option) on ppc
filter-flags "-maltivec -mabi=altivec -fPIC"
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
