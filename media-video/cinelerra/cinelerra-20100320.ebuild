# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra/cinelerra-20100320.ebuild,v 1.6 2010/08/15 21:01:01 ssuominen Exp $

EAPI=2
inherit autotools eutils multilib flag-o-matic

DESCRIPTION="Cinelerra - Professional Video Editor - Unofficial GIT-version"
HOMEPAGE="http://www.cinelerra.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="3dnow alsa altivec css ieee1394 mmx opengl oss"

RDEPEND="media-libs/libpng
	>=media-libs/libdv-1.0.0
	media-libs/faad2
	media-libs/faac
	media-libs/a52dec
	media-libs/libsndfile
	media-libs/tiff
	media-video/ffmpeg
	media-sound/lame
	>=sci-libs/fftw-3.0.1
	media-libs/x264
	media-video/mjpegtools
	>=media-libs/freetype-2.1.10
	>=media-libs/openexr-1.2.2
	>=media-libs/libvorbis-1.2.3
	>=media-libs/libogg-1.1.4
	>=media-libs/libtheora-1.1.1
	x11-libs/libX11
	x11-libs/libXv
	x11-libs/libXxf86vm
	x11-libs/libXext
	x11-libs/libXvMC
	x11-libs/libXft
	alsa? ( media-libs/alsa-lib )
	ieee1394? ( media-libs/libiec61883
		>=sys-libs/libraw1394-1.2.0
		>=sys-libs/libavc1394-0.5.0 )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	mmx? ( dev-lang/nasm )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-libavutil50.patch \
		"${FILESDIR}"/${P}-pkgconfig-x264.patch \
		"${FILESDIR}"/${PN}-x264.patch \
		"${FILESDIR}"/${PN}-jpeg-7.patch \
		"${FILESDIR}"/${P}-libpng14.patch \
		"${FILESDIR}"/${P}-gcc45.patch \
		"${FILESDIR}"/${P}-glibc212.patch
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	#bug #321945 (UINT64_C vs ffmpeg headers)
	append-flags -D__STDC_CONSTANT_MACROS
	econf \
		--disable-dependency-tracking \
		$(use_enable oss) \
		$(use_enable alsa) \
		--disable-esd \
		$(use_enable ieee1394 firewire) \
		$(use_enable css) \
		$(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable altivec) \
		$(use_enable opengl) \
		--with-plugindir=/usr/$(get_libdir)/cinelerra \
		--with-buildinfo=cust/"Gentoo - ${PV}" \
		--with-external-ffmpeg
}

src_install() {
	emake DESTDIR="${D}" install || die
	dohtml -a png,html,texi,sdw -r doc/*
	# workaround
	rm -rf "${D}"/usr/include
	mv -v "${D}"/usr/bin/mpeg3cat "${D}"/usr/bin/mpeg3cat.hv
	mv -v "${D}"/usr/bin/mpeg3dump "${D}"/usr/bin/mpeg3dump.hv
	mv -v "${D}"/usr/bin/mpeg3toc "${D}"/usr/bin/mpeg3toc.hv
	dosym /usr/bin/mpeg2enc /usr/$(get_libdir)/cinelerra/mpeg2enc.plugin
}
