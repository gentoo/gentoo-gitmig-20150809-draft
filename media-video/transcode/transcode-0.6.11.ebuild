# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.11.ebuild,v 1.2 2003/12/26 15:32:26 mholzer Exp $

inherit libtool flag-o-matic eutils
# Don't build with -mfpmath=sse || -fPic or it will break. (Bug #14920)
filter-mfpmath sse
filter-flags -fPIC
filter-flags -maltivec -mabi=altivec

MY_P="${P/_pre/.}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://zebra.fh-weingarten.de/~transcode/"
SRC_URI="http://www.zebra.fh-weingarten.de/~transcode/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="sdl mmx mpeg sse 3dnow encode X quicktime avi altivec"

DEPEND=">=media-libs/a52dec-0.7.4
	>=media-libs/libdv-0.99
	x86? ( >=dev-lang/nasm-0.98.36 )
	>=media-libs/libdvdread-0.9.0
	>=media-video/ffmpeg-0.4.6
	>=media-libs/xvid-0.9.1
	>=media-video/mjpegtools-1.6.0
	>=dev-libs/lzo-1.08
	>=media-libs/libfame-0.9.0
	>=media-gfx/imagemagick-5.5.6.0
	media-libs/netpbm
	X? ( virtual/x11 )
	avi? (	>=media-video/avifile-0.7.38 )
	avi? ( x86? ( >=media-libs/divx4linux-20030428 ) )
	mpeg? ( media-libs/libmpeg3 )
	encode? ( >=media-sound/lame-3.93 )
	sdl? ( media-libs/libsdl )
	quicktime? ( virtual/quicktime )"

src_unpack() {
	unpack ${A}

	if has_version  '>=media-libs/netpbm-9.13'
	then
		einfo "New netbpm (>9.12)..."
		sed -i 's:-lppm:-lnetpbm:' \
			${S}/contrib/subrip/Makefile
	else
		einfo "Old netbpm (<=9.12)..."
	fi

	cd ${S}
	epatch ${FILESDIR}/${P}-no-mmx.patch
}

src_compile() {
	local myconf="--with-dvdread"

	# fix invalid paths in .la files of plugins
	elibtoolize

	use mmx \
		&& myconf="${myconf} --enable-mmx"
	use mmx || ( use 3dnow || use sse ) \
		|| myconf="${myconf} --disable-mmx"
	# Dont disable mmx if 3dnow or sse are requested.

	use sse \
		&& myconf="${myconf} --enable-sse" \
		|| myconf="${myconf} --disable-sse"

	use 3dnow \
		&& myconf="${myconf} --enable-3dnow" \
		|| myconf="${myconf} --disable-3dnow"

	use altivec \
		&& myconf="${myconf} --enable-altivec" \
		|| myconf="${myconf} --disable-altivec"

	use avi \
		&& myconf="${myconf} --with-avifile-mods --enable-avifile6" \
		|| myconf="${myconf} --without-avifile-mods --disable-avifile6"

	use encode \
		&& myconf="${myconf} --with-lame" \
		|| myconf="${myconf} --without-lame"

	use mpeg \
		&& myconf="${myconf} --with-libmpeg3" \
		|| myconf="${myconf} --without-libmpeg3"

	if [ "`use quicktime`" ]; then
		has_version 'media-libs/openquicktime' \
			&& myconf="${myconf} --with-openqt --without-qt" \
			|| myconf="${myconf} --without-openqt --with-qt"
	fi

	use X \
		&& myconf="${myconf} --enable-x" \
		|| myconf="${myconf} --disable-x"

	# Use the MPlayer libpostproc if present
	[ -f ${ROOT}/usr/lib/libpostproc.a ] && \
	[ -f ${ROOT}/usr/include/postproc/postprocess.h ] && \
		myconf="${myconf} --with-libpostproc-builddir=${ROOT}/usr/lib"

	econf ${myconf} CFLAGS="${CFLAGS} -DDCT_YUV_PRECISION=1" || die

	# Do not use emake !!
	# export CFLAGS="${CFLAGS} -DDCT_YUV_PRECISION=1"

	# workaround for including avifile haders, which are expected
	# in an directory named "avifile"
	use avi \
		&& avi_inc=$(avifile-config --cflags | sed -e "s|^-I||") \
		&& [ -d "$avi_inc" ] \
		&& [ "$(basename "$avi_inc")" != "avifile" ] \
		&& ln -s "$avi_inc" avifile

	make all || die

	# subrip stuff
	cd contrib/subrip
	make || die
}

src_install () {
	make \
		DESTDIR=${D} \
		install || die

	dodoc AUTHORS COPYING ChangeLog README TODO

	# subrip stuff
	cd contrib/subrip
	dobin pgm2txt srttool subtitle2pgm subtitle2vobsub
	einfo ""
	einfo "This ebuild uses subtitles !!!"
	einfo ""
}
