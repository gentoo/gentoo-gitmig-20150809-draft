# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.12.ebuild,v 1.3 2004/02/07 19:32:18 vapier Exp $

inherit libtool flag-o-matic eutils

MY_P="${P/_pre/.}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://zebra.fh-weingarten.de/~transcode/"
SRC_URI="http://www.zebra.fh-weingarten.de/~transcode/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="sdl mmx mpeg sse 3dnow encode X quicktime avi altivec"

DEPEND=">=media-libs/a52dec-0.7.4
	=sys-devel/gcc-3*
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
	cd ${S}

	if has_version  '>=media-libs/netpbm-9.13'
	then
		einfo "New netbpm (>9.12)..."
		sed -i 's:-lppm:-lnetpbm:' \
			contrib/subrip/Makefile
	else
		einfo "Old netbpm (<=9.12)..."
	fi
}

src_compile() {
	# Don't build with -mfpmath=sse (Bug #14920)
	filter-mfpmath sse
	filter-flags -maltivec -mabi=altivec

	local myconf="--with-dvdread"

	# fix invalid paths in .la files of plugins
	elibtoolize

	if [ "`use quicktime`" ]; then
		has_version 'media-libs/openquicktime' \
			&& myconf="${myconf} --with-openqt --without-qt" \
			|| myconf="${myconf} --without-openqt --with-qt"
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
		`use_with avi avifile-mods` \
		`use_enable avi avifile6` \
		`use_enable encode lame` \
		`use_enable mpeg libmpeg3` \
		`use_enable X x` \
		${myconf} \
		|| die

	# workaround for including avifile haders, which are expected
	# in an directory named "avifile"
	use avi \
		&& avi_inc=$(avifile-config --cflags | sed -e "s|^-I||") \
		&& [ -d "$avi_inc" ] \
		&& [ "$(basename "$avi_inc")" != "avifile" ] \
		&& ln -s "$avi_inc" avifile

	emake -j1 all || die

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
