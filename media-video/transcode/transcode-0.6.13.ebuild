# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.13.ebuild,v 1.3 2004/10/28 12:14:31 zypher Exp $

inherit libtool flag-o-matic eutils

MY_P="${P/_pre/.}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://zebra.fh-weingarten.de/~transcode/"
SRC_URI="http://vtel.rgv.net/~ahze/dist/${MY_P}.tar.gz
	http://www.jakemsr.com/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="X 3dnow avi altivec divx4linux encode mmx mpeg oggvorbis quicktime sdl sse theora"

DEPEND=">=media-libs/a52dec-0.7.4
	=sys-devel/gcc-3*
	>=media-libs/libdv-0.99
	x86? ( >=dev-lang/nasm-0.98.36 )
	>=media-libs/libdvdread-0.9.0
	>=media-video/ffmpeg-0.4.6
	>=media-libs/xvid-1.0.2
	>=media-video/mjpegtools-1.6.0
	>=dev-libs/lzo-1.08
	>=media-libs/libfame-0.9.0
	>=media-gfx/imagemagick-5.5.6.0
	media-libs/netpbm
	X? ( virtual/x11 )
	avi? (	>=media-video/avifile-0.7.41.20041001 )
	divx4linux? ( x86? ( >=media-libs/divx4linux-20030428 ) )
	mpeg? ( media-libs/libmpeg3 )
	encode? ( >=media-sound/lame-3.93 )
	sdl? ( media-libs/libsdl )
	quicktime? ( >=media-libs/libquicktime-0.9.3 )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	filter-flags -maltivec -mabi=altivec

	local myconf="--with-dvdread --enable-mjpegtools  --with-mjpegtools \
		--enable-imagemagick --enable-lzo --enable-a52 --enable-fame"

	# fix invalid paths in .la files of plugins
	elibtoolize

	use quicktime && myconf="${myconf} --enable-libquicktime"

#	if use quicktime; then
#		has_version 'media-libs/libquicktime' \
#		&& myconf="${myconf} --enable-libquicktime" \
#		|| einfo "Libquicktime needed for quicktime support"
#	fi

	if use avi; then
		myconf="${myconf} --enable-avifile --with-avifile"
	fi

	if use oggvorbis; then
		myconf="${myconf} --enable-ogg --enable-vorbis"
	fi



	# Use the MPlayer libpostproc if present
	[ -f ${ROOT}/usr/lib/libpostproc.a ] && \
	[ -f ${ROOT}/usr/include/postproc/postprocess.h ] && \
		myconf="${myconf} --with-libpostproc-builddir=${ROOT}/usr/lib"

	econf \
		CFLAGS="${CFLAGS} -DDCT_YUV_PRECISION=1" \
		`use_enable mmx` \
		`use_enable sse` \
		`use_enable 3dnow` \
		`use_enable altivec` \
		`use_enable theora` \
		`use_enable sdl` \
		`use_enable encode lame` \
		`use_enable mpeg libmpeg3` \
		`use_enable X x` \
		${myconf} \
		|| die

	emake -j1 all || die
}

src_install () {
	make \
		DESTDIR=${D} \
		install || die

	dodoc AUTHORS COPYING ChangeLog README TODO
}
