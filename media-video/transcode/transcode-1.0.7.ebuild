# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-1.0.7.ebuild,v 1.2 2009/01/07 13:38:06 fmccor Exp $

WANT_AUTOMAKE="1.8"

inherit libtool flag-o-matic eutils multilib autotools

MY_P="${P/_rc/rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Utilities for transcoding video, audio and container formats."
HOMEPAGE="http://www.transcoding.org/cgi-bin/transcode"
SRC_URI="http://fromani.exit1.org/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 sparc ~x86"
IUSE="X 3dnow a52 altivec dv dvdread extrafilters mp3 fame truetype iconv
imagemagick jpeg lzo mjpeg mpeg mmx network nuv ogg oss vorbis quicktime sdl sse sse2 theora v4l2 xvid xml"

RDEPEND="a52? ( >=media-libs/a52dec-0.7.4 )
	dv? ( >=media-libs/libdv-0.99 )
	dvdread? ( >=media-libs/libdvdread-0.9.0 )
	xvid? ( >=media-libs/xvid-1.0.2 )
	mjpeg? ( >=media-video/mjpegtools-1.6.2-r3 )
	lzo? ( =dev-libs/lzo-2* )
	fame? ( >=media-libs/libfame-0.9.1 )
	imagemagick? ( >=media-gfx/imagemagick-6.4.0.6 )
	mpeg? ( media-libs/libmpeg3 )
	mp3? ( >=media-sound/lame-3.93 )
	sdl? ( media-libs/libsdl )
	quicktime? ( >=media-libs/libquicktime-0.9.8 )
	vorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )
	nuv? ( =dev-libs/lzo-2* )
	theora? ( media-libs/libtheora )
	jpeg? ( media-libs/jpeg )
	truetype? ( >=media-libs/freetype-2 )
	>=media-video/ffmpeg-0.4.9_p20081014
	|| ( sys-libs/glibc dev-libs/libiconv )
	>=media-libs/libmpeg2-0.4.0b
	xml? ( dev-libs/libxml2 )
	X? ( x11-libs/libXaw
		x11-libs/libXv )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	v4l2? ( >=sys-kernel/linux-headers-2.6.11 )"

pkg_setup() {
	if use sdl && use X && ! built_with_use media-libs/libsdl X; then
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

	epatch "${FILESDIR}/${PN}-1.0.6-imagemagick.patch"
	eautoreconf
}

src_compile() {

	strip-flags
	local myconf

	if use ppc || use ppc64 ; then
		append-flags -U__ALTIVEC__
	fi

	append-flags -DDCT_YUV_PRECISION=1

	use xvid && myconf="${myconf} --with-default-xvid=xvid4"
	# Follow upstreams suggestion about a52, libac3 is deprecated
	use a52 && myconf="${myconf} --enable-a52 --enable-a52-default-decoder"
	myconf="${myconf} \
		$(use_enable mmx) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable 3dnow) \
		$(use_enable altivec) \
		$(use_enable network netstream) \
		$(use_enable truetype freetype2) \
		$(use_enable v4l2 v4l) \
		$(use_enable mp3 lame) \
		$(use_enable nuv) \
		$(use_enable ogg) \
		$(use_enable oss) \
		$(use_enable vorbis) \
		$(use_enable theora) \
		$(use_enable dvdread libdvdread) \
		$(use_enable dv libdv) \
		$(use_enable quicktime libquicktime) \
		$(use_enable lzo) \
		$(use_enable iconv) \
		$(use_enable mpeg libmpeg3) \
		$(use_enable xml libxml2) \
		$(use_enable mjpeg mjpegtools) \
		$(use_enable sdl) \
		$(use_enable fame libfame) \
		$(use_enable imagemagick) \
		$(use_enable jpeg libjpeg) \
		$(use_with X x) \
		--with-mod-path=/usr/$(get_libdir)/transcode \
		--with-libpostproc-prefix=/usr/$(get_libdir) \
		--disable-avifile \
		--disable-xio"
	econf ${myconf} || die "econf died"

	emake all || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install died"

	#do not install the filters that make dvdrip hang unless we ask for them
	if ! use extrafilters ; then
		rm "${D}"/usr/$(get_libdir)/transcode/filter_logo.*
		rm "${D}"/usr/$(get_libdir)/transcode/filter_compare.*
	fi

	dodoc AUTHORS ChangeLog README TODO README-1.0.1
	dodoc docs/*.txt docs/README.* docs/OPTIMIZERS docs/faq
	dohtml docs/html/*
	doman docs/man/*.1
}
