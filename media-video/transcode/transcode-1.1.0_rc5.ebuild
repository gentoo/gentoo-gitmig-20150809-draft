# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-1.1.0_rc5.ebuild,v 1.1 2009/01/07 11:52:41 aballier Exp $

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.10"

inherit libtool flag-o-matic eutils multilib autotools

MY_P=${P/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://www.transcoding.org/cgi-bin/transcode"
SRC_URI="http://fromani.exit1.org/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X 3dnow a52 aac alsa altivec dv dvdread iconv imagemagick jpeg lzo mjpeg mp3 mmx nuv ogg oss postproc quicktime sdl sse sse2 theora truetype v4l2 vorbis x264 xvid xml"

RDEPEND="a52? ( media-libs/a52dec )
	alsa? ( media-libs/alsa-lib )
	dv? ( media-libs/libdv )
	dvdread? ( media-libs/libdvdread )
	xvid? ( media-libs/xvid )
	mjpeg? ( media-video/mjpegtools )
	lzo? ( >=dev-libs/lzo-2 )
	imagemagick? ( media-gfx/imagemagick )
	mp3? ( media-sound/lame )
	sdl? ( media-libs/libsdl )
	quicktime? ( >=media-libs/libquicktime-1.0.0 )
	vorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )
	theora? ( media-libs/libtheora )
	jpeg? ( media-libs/jpeg )
	truetype? ( >=media-libs/freetype-2 )
	>=media-video/ffmpeg-0.4.9_p20081014
	|| ( sys-libs/glibc dev-libs/libiconv )
	media-libs/libmpeg2
	x264? ( media-libs/x264 )
	xml? ( dev-libs/libxml2 )
	X? ( x11-libs/libXpm
		x11-libs/libXaw
		x11-libs/libXv )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	v4l2? ( >=sys-kernel/linux-headers-2.6.11 )"
# Make sure the assembler USE flags are unmasked on amd64
# Remove this once default-linux/amd64/2006.1 is deprecated
DEPEND="${DEPEND} amd64? ( >=sys-apps/portage-2.1.2 )"

pkg_setup() {
	if use X && ! built_with_use media-libs/libsdl X; then
		eerror "media-libs/libsdl must be built with the X use flag."
		die "fix use flags"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:\$(datadir)/doc/transcode:\$(datadir)/doc/${PF}:" \
		"${S}"/Makefile.am "${S}"/docs/Makefile.am "${S}"/docs/html/Makefile.am \
		"${S}"/docs/release-notes/Makefile.am

	eautoreconf
}

src_compile() {
	use xvid && myconf="${myconf} --with-default-xvid=xvid4"
	# NuppelVideo is supported only on x86 platform yet
	# TODO: mask nuv useflag for all other arches
	use x86 && myconf="${myconf} $(use_enable nuv)"
	myconf="${myconf} \
		$(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable altivec) \
		$(use_enable v4l2 v4l) \
		$(use_enable alsa) \
		$(use_enable oss) \
		$(use_enable truetype freetype2) \
		$(use_enable mp3 lame) \
		$(use_enable x264) \
		$(use_enable xvid) \
		$(use_enable ogg) \
		$(use_enable vorbis) \
		$(use_enable theora) \
		$(use_enable dvdread libdvdread) \
		$(use_enable dv libdv) \
		$(use_enable quicktime libquicktime) \
		$(use_enable imagemagick) \
		$(use_enable postproc libpostproc) \
		$(use_enable lzo) \
		$(use_enable a52) \
		$(use_enable aac faac) \
		$(use_enable xml libxml2) \
		$(use_enable mjpeg mjpegtools) \
		$(use_enable sdl) \
		$(use_enable jpeg libjpeg) \
		$(use_enable iconv) \
		$(use_with X x) \
		--with-mod-path=/usr/$(get_libdir)/transcode"

	econf ${myconf} || die "econf failed"

	emake all || die "emake all failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	rm -fr "${D}/usr/share/doc/transcode"

	dodoc AUTHORS ChangeLog README TODO STYLE
	dodoc docs/*
	dohtml docs/html/*
}
