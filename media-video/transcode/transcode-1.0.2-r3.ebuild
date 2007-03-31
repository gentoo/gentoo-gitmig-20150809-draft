# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-1.0.2-r3.ebuild,v 1.14 2007/03/31 13:39:59 beandog Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest

inherit libtool flag-o-matic eutils multilib autotools

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://www.transcoding.org/cgi-bin/transcode"
SRC_URI="mirror://transcode/${MY_P}.tar.gz
	mirror://gentoo/transcode-types.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="X 3dnow a52 altivec dv dvdread extrafilters mp3 fame truetype gtk imagemagick jpeg
lzo mjpeg mpeg mmx network ogg vorbis quicktime sdl sse sse2 theora v4l2
xvid xml"

RDEPEND="a52? ( >=media-libs/a52dec-0.7.4 )
	dv? ( >=media-libs/libdv-0.99 )
	dvdread? ( >=media-libs/libdvdread-0.9.0 )
	xvid? ( >=media-libs/xvid-1.0.2 )
	mjpeg? ( >=media-video/mjpegtools-1.6.2-r3 )
	lzo? ( >=dev-libs/lzo-2 )
	fame? ( >=media-libs/libfame-0.9.1 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6.0 )
	mpeg? ( media-libs/libmpeg3 )
	mp3? ( >=media-sound/lame-3.93 )
	sdl? ( media-libs/libsdl )
	quicktime? ( >=media-libs/libquicktime-0.9.3 )
	vorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )
	theora? ( media-libs/libtheora )
	jpeg? ( media-libs/jpeg )
	gtk? ( =x11-libs/gtk+-1.2* )
	truetype? ( >=media-libs/freetype-2 )
	>=media-video/ffmpeg-0.4.9_p20050226-r3
	|| ( sys-libs/glibc dev-libs/libiconv )
	>=media-libs/libmpeg2-0.4.0b
	xml? ( dev-libs/libxml2 )
	X? ( x11-libs/libXaw
		x11-libs/libXv )"

DEPEND="${RDEPEND}
	v4l2? ( >=sys-kernel/linux-headers-2.6.11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:\$(datadir)/doc/transcode:\$(datadir)/doc/${PF}:" \
		"${S}"/Makefile.am "${S}"/docs/Makefile.am "${S}"/docs/html/Makefile.am \
		"${S}"/docs/release-notes/Makefile.am

	epatch "${FILESDIR}/${P}-bigdir.patch"
	epatch "${FILESDIR}/${P}-lzo2.patch"
	epatch "${DISTDIR}/${PN}-types.patch.bz2"
	epatch "${FILESDIR}/${P}-autoconf259d.patch"
	epatch "${FILESDIR}/${P}-new-ffmpeg"
	# Fix to compile against media-libs/libmpeg3-1.7
	use mpeg && has_version '>=media-libs/libmpeg3-1.7' \
		&& epatch "${FILESDIR}/${P}-libmpeg3-1.7.patch"

	eautoreconf
}

src_compile() {
	filter-flags -maltivec -mabi=altivec -momit-leaf-frame-pointer
	#145849
	use amd64 && filter-flags -fweb

	if use ppc || use ppc64 ; then
		append-flags -U__ALTIVEC__
	fi

	use xvid \
		&& myconf="${myconf} --with-default-xvid=xvid4"

	# Hardenable SIMD extensions on amd64
	if use amd64; then
		myconf="${myconf} --enable-mmx \
				--enable-sse --enable-sse2"
	elif use x86; then
		myconf="${myconf} $(use_enable mmx) \
				$(use_enable sse) \
				$(use_enable sse2)"
	fi
	myconf="${myconf} $(use_enable 3dnow)"

	append-flags -DDCT_YUV_PRECISION=1
	econf \
		$(use_enable altivec) \
		$(use_enable network netstream) \
		$(use_enable truetype freetype2) \
		$(use_enable v4l2 v4l) \
		$(use_enable mp3 lame) \
		$(use_enable ogg) \
		$(use_enable vorbis) \
		$(use_enable theora) \
		$(use_enable dvdread libdvdread) \
		$(use_enable dv libdv) \
		$(use_enable quicktime libquicktime) \
		$(use_enable lzo) \
		$(use_enable a52) \
		$(use_enable mpeg libmpeg3) \
		$(use_enable xml libxml2) \
		$(use_enable mjpeg mjpegtools) \
		$(use_enable sdl) \
		$(use_enable gtk) \
		$(use_enable fame libfame) \
		$(use_enable imagemagick) \
		$(use_enable jpeg libjpeg) \
		--with-mod-path=/usr/$(get_libdir)/transcode \
		$(use_with X x) \
		${myconf} \
		--with-libpostproc-builddir="/usr/$(get_libdir)" \
		--with-lzo-includes=/usr/include/lzo \
		--disable-avifile \
		|| die

	emake all || die
}

src_install () {
	make DESTDIR="${D}" install || die

	#do not install the filters that make dvdrip hang unless we ask for them
	if ! use extrafilters ; then
	rm "${D}"/usr/$(get_libdir)/transcode/filter_logo.*
	rm "${D}"/usr/$(get_libdir)/transcode/filter_compare.*
	fi

	dodoc AUTHORS ChangeLog README TODO
}
