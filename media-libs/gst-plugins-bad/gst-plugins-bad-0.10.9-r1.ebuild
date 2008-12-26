# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-bad/gst-plugins-bad-0.10.9-r1.ebuild,v 1.1 2008/12/26 12:48:38 ssuominen Exp $

EAPI=2

inherit flag-o-matic

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.sourceforge.net"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac amrwb encode bzip2 gsm debug dts dvb jack ladspa libmms musepack
musicbrainz mythtv neon nls sdl sndfile twolame vcd"

RDEPEND=">=dev-libs/glib-2.12:2
	>=media-libs/gstreamer-0.10.21-r2
	>=media-libs/gst-plugins-base-0.10.21-r1
	>=dev-libs/liboil-0.3.14
	jack? ( media-sound/jack-audio-connection-kit )
	amrwb? ( media-libs/amrwb )
	bzip2? ( app-arch/bzip2 )
	dts? ( media-libs/libdca )
	gsm? ( =media-sound/gsm-1.0.12-r1 )
	ladspa? ( >=media-libs/ladspa-sdk-1.12-r2 )
	libmms? ( media-libs/libmms )
	musepack? ( >=media-libs/libmpcdec-1.2 )
	twolame? ( media-sound/twolame )
	neon? ( >=net-misc/neon-0.26 )
	mythtv? ( media-libs/gmyth )
	aac? ( >=media-libs/faad2-2.6.1 )
	encode? ( aac? ( media-libs/faac ) )
	sndfile? ( media-libs/libsndfile )
	sdl? ( media-libs/libsdl )
	musicbrainz? ( =media-libs/musicbrainz-2* )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	vcd? ( virtual/os-headers )
	dvb? ( virtual/os-headers )
	!media-plugins/gst-plugins-amrwb
	!media-plugins/gst-plugins-dvb
	!media-plugins/gst-plugins-faac
	!media-plugins/gst-plugins-faad
	!media-plugins/gst-plugins-ladspa
	!media-plugins/gst-plugins-libmms
	!media-plugins/gst-plugins-musepack
	!media-plugins/gst-plugins-mythtv
	!media-plugins/gst-plugins-neon"

src_configure() {
	local encode="--disable-faac"

	if use encode; then
		use aac && encode="--enable-faac"
	fi

	econf \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable debug) \
		--disable-valgrind \
		--disable-examples \
		--disable-quicktime \
		$(use_enable vcd) \
		--disable-alsa \
		$(use_enable amrwb) \
		--disable-apexsink \
		$(use_enable bzip2 bz2) \
		--disable-cdaudio \
		--disable-celt \
		--disable-dc1394 \
		--disable-directfb \
		--disable-dirac \
		$(use_enable dts) \
		--disable-divx \
		--disable-dvdnav \
		$(use_enable gsm) \
		--disable-metadata \
		$(use_enable aac faad) \
		--disable-fbdev \
		$(use_enable jack) \
		$(use_enable ladspa) \
		--disable-jp2k \
		$(use_enable libmms) \
		--disable-mplex \
		--disable-mpeg2enc \
		$(use_enable musepack) \
		$(use_enable musicbrainz) \
		$(use_enable mythtv) \
		--disable-nas \
		$(use_enable neon) \
		--disable-ofa \
		--disable-timidity \
		--disable-wildmidi \
		$(use_enable twolame) \
		$(use_enable sdl) \
		$(use_enable sndfile) \
		--disable-soundtouch \
		--disable-spc \
		--disable-swfdec \
		--disable-theoradec \
		--disable-x264 \
		--disable-xvid \
		$(use_enable dvb) \
		--disable-oss4 \
		--disable-wininet \
		--disable-acm \
		--with-package-name="GStreamer ebuild for Gentoo" \
		--with-package-origin="http://packages.gentoo.org/package/media-libs/${PN}" \
		${encode}
}

src_compile() {
	# GStreamer doesn't handle optimization so well
	strip-flags
	replace-flags -O3 -O2
	filter-flags -fprefetch-loop-arrays

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README RELEASE

	# Drop unnecessary libtool files
	find "${D}"/usr -name '*.la' -delete
}
