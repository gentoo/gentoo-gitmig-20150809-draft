# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.12-r1.ebuild,v 1.16 2005/02/20 00:14:45 luckyduck Exp $

inherit libtool flag-o-matic eutils gcc

MY_P="${P/_pre/.}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://zebra.fh-weingarten.de/~transcode/"
SRC_URI="http://www.zebra.fh-weingarten.de/~transcode/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc amd64"
IUSE="sdl mpeg sse 3dnow encode X quicktime avi altivec oggvorbis theora"

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
	divx4linux? ( x86? ( >=media-libs/divx4linux-20030428 ) )
	mpeg? ( media-libs/libmpeg3 )
	encode? ( >=media-sound/lame-3.93 )
	sdl? ( media-libs/libsdl )
	quicktime? ( virtual/quicktime )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	theora? ( media-libs/libtheora )"

src_unpack() {

	unpack ${A}
	cd ${S}

	#apply both patches to compile with gcc-3.4.0 closing bug #49457
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch ${FILESDIR}/transcode-gcc34.patch
		epatch ${FILESDIR}/transcode-0.6.12-gcc-3.4.patch
	fi

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
	filter-flags -maltivec -mabi=altivec -fforce-addr -momit-leaf-frame-pointer
	# BREG error with -fPIC
	# ---
	# really ? no on amd64, and we need -fPIC.
	# Danny van Dyk <kugelfang@gentoo.org> 2004/05/25
	use !amd64 && filter-flags -fPIC

	local myconf="--with-dvdread"

	# fix invalid paths in .la files of plugins
	elibtoolize

	if use quicktime; then
		has_version 'media-libs/openquicktime' \
			&& myconf="${myconf} --with-openqt --without-qt" \
			|| myconf="${myconf} --without-openqt --with-qt"
	fi

	# Use the MPlayer libpostproc if present
	[ -f ${ROOT}/usr/$(get_libdir)/libpostproc.a ] && \
	[ -f ${ROOT}/usr/include/postproc/postprocess.h ] && \
		myconf="${myconf} --with-libpostproc-builddir=${ROOT}/usr/$(get_libdir)"

	econf \
		CFLAGS="${CFLAGS} -DDCT_YUV_PRECISION=1" \
		`use_enable sse` \
		`use_enable 3dnow` \
		`use_enable altivec` \
		`use_with avi avifile-mods` \
		`use_enable avi avifile6` \
		`use_enable encode lame` \
		`use_enable mpeg libmpeg3` \
		`use_with oggvorbis ogg` \
		`use_with oggvorbis vorbis` \
		`use_with theora` \
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

	einfo "if this fails with broken kde libs, try reemerge avifile"
	einfo "also add mmx to your USE flags if you cpu supports it"
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
