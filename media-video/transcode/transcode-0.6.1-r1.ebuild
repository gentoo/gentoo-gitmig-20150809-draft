# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.1-r1.ebuild,v 1.5 2003/02/15 16:53:06 mholzer Exp $

IUSE="sdl mmx mpeg sse dvd encode X quicktime avi"

inherit libtool

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
SRC_URI="http://www.theorie.physik.uni-goettingen.de/~ostreich/transcode/${MY_P}.tgz"
HOMEPAGE="http://www.theorie.physik.uni-goettingen.de/~ostreich/transcode"

# Note: transcode can use pretty much any media-related package ever written as
# a plugin. An exhaustive dep list would make me add about 20-30 packages to 
# portage. perhaps another time :-)

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"

DEPEND=">=media-libs/a52dec-0.7.3
	>=media-libs/libdv-0.9.5
	>=media-video/mplayer-0.90_pre10
	x86? ( dev-lang/nasm )
	X? ( virtual/x11 )
	avi? (	<=media-video/avifile-0.7.22 	
		>=media-video/avifile-0.7.4 )
	dvd? ( media-libs/libdvdread )
	mpeg? ( media-libs/libmpeg3 )
	encode? ( >=media-sound/lame-3.89 )
	sdl? ( media-libs/libsdl )
	quicktime? ( media-libs/quicktime4linux )
	<=media-video/avifile-0.7.22 
	>=media-video/avifile-0.7.4
	media-libs/libdvdread"

src_unpack() {

	unpack ${A}

	# Fix GET_PP_QUALITY_MAX error
	cd ${S}; patch -p1 <  ${FILESDIR}/${MY_P}-PP_QUALITY_MAX.patch || die

}

src_compile() {

	# fix invalid paths in .la files of plugins
	elibtoolize

	local myconf=""

	use mmx \
		&& myconf="${myconf} --enable-mmx"
	use mmx || ( use 3dnow || use sse ) \
		|| myconf="${myconf} --disable-mmx"
	# Dont disable mmx if 3dnow or sse are requested.

	use sse \
		&& myconf="${myconf} --enable-sse" \
		|| myconf="${myconf} --disable-sse"

	myconf="${myconf} --with-dvdread --with-avifile-mods --enable-avifile6"   

	use encode \
		&& myconf="${myconf} --with-lame" \
		|| myconf="${myconf} --without-lame"
	
	use mpeg \
		&& myconf="${myconf} --with-libmpeg3" \
		|| myconf="${myconf} --without-libmpeg3"

	use quicktime \
		|| myconf="${myconf} --without-qt --without-openqt"

	use X \
		&& myconf="${myconf} --enable-x" \
		|| myconf="${myconf} --disable-x"

	# Use the MPlayer libpostproc if present
	[ -f ${ROOT}/usr/lib/libpostproc.a ] && \
	[ -f ${ROOT}/usr/include/postprocess.h ] && \
		myconf="${myconf} --with-libpostproc-builddir=${ROOT}/usr/lib"
	
	econf ${myconf} || die

	# Do not use emake !!
	make all || die
}

src_install () {

	make \
		DESTDIR=${D} \
		install || die
	
	dodoc AUTHORS COPYING ChangeLog README TODO
}

