# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.14-r3.ebuild,v 1.11 2006/03/14 23:55:10 flameeyes Exp $

inherit libtool flag-o-matic eutils multilib autotools

PATCH_VER=${PVR}

MY_P="${P/_pre/.}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://www.transcoding.org/cgi-bin/transcode"
SRC_URI="mirror://transcode/${P}.tar.gz
	http://rebels.plukwa.net/linux-video/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-patches-${PATCH_VER}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="X 3dnow a52 altivec dv dvdread encode fame truetype gtk imagemagick jpeg
lzo mjpeg mpeg mmx network ogg vorbis quicktime sdl sse sse2 theora v4l
xvid xml"

RDEPEND="a52? ( >=media-libs/a52dec-0.7.4 )
	dv? ( >=media-libs/libdv-0.99 )
	dvdread? ( >=media-libs/libdvdread-0.9.0 )
	>=media-video/ffmpeg-0.4.9_p20050906
	xvid? ( >=media-libs/xvid-1.0.2 )
	mjpeg? ( >=media-video/mjpegtools-1.6.2-r3 )
	lzo? ( >=dev-libs/lzo-1.08 )
	fame? ( >=media-libs/libfame-0.9.1 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6.0 )
	media-libs/netpbm
	media-libs/libexif
	X? ( || ( ( x11-libs/libXaw
				x11-libs/libXi
				x11-libs/libXv
			)
			virtual/x11
		)
	)
	mpeg? ( media-libs/libmpeg3 )
	encode? ( >=media-sound/lame-3.93 )
	sdl? ( media-libs/libsdl )
	quicktime? ( >=media-libs/libquicktime-0.9.3 )
	vorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )
	theora? ( media-libs/libtheora )
	xml? ( dev-libs/libxml2 )
	jpeg? ( media-libs/jpeg )
	gtk? ( =x11-libs/gtk+-1.2* )
	truetype? ( >=media-libs/freetype-2 )"

DEPEND="${RDEPEND}
	X? ( || ( x11-proto/xextproto virtual/x11 ) )
	x86? ( >=dev-lang/nasm-0.98.36 )
	=sys-devel/gcc-3*"

pkg_setup() {
	if has_version x11-base/xorg-x11 && ! built_with_use x11-base/xorg-x11 xv; then
		die "You need xorg-x11 emerged with xv support to compile transcode."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/${PATCH_VER}/

	eautoreconf
	elibtoolize	# fix invalid paths in .la files of plugins
}

src_compile() {
	filter-flags -maltivec -mabi=altivec -momit-leaf-frame-pointer
	use ppc && append-flags -U__ALTIVEC__

	use xvid \
		&& myconf="${myconf} --with-default-xvid=xvid4"

	# Use the MPlayer libpostproc if present
	[ -f ${ROOT}/usr/$(get_libdir)/libpostproc.a ] && \
	[ -f ${ROOT}/usr/include/postproc/postprocess.h ] && \
		myconf="${myconf} --with-libpostproc-builddir=${ROOT}/usr/$(get_libdir)"

	append-flags -DDCT_YUV_PRECISION=1
	econf \
		--with-mod-path=/usr/$(get_libdir)/transcode \
		$(use_enable X x) \
		$(use_enable 3dnow) \
		$(use_enable a52) \
		$(use_enable altivec) \
		$(use_enable dv libdv) \
		$(use_enable dvdread libdvdread) \
		$(use_enable encode lame) \
		$(use_enable fame libfame) \
		$(use_enable truetype freetype2) \
		$(use_enable gtk) \
		$(use_enable imagemagick) \
		$(use_enable jpeg libjpeg) \
		$(use_enable lzo) \
		$(use_enable mjpeg mjpegtools) \
		$(use_enable mmx) \
		$(use_enable mpeg libmpeg3) \
		$(use_enable network netstream) \
		$(use_enable ogg) \
		$(use_enable vorbis) \
		$(use_enable quicktime libquicktime) \
		$(use_enable sdl) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable theora) \
		$(use_enable v4l) \
		$(use_enable xml libxml2) \
		${myconf} \
		--disable-avifile \
		|| die "econf failed"

	emake -j1 all || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog README TODO
}
