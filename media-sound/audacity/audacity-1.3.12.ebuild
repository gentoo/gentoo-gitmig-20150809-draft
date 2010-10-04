# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.3.12.ebuild,v 1.2 2010/10/04 08:52:58 dirtyepic Exp $

EAPI=2

inherit eutils wxwidgets autotools versionator

IUSE="alsa ffmpeg flac id3tag jack ladspa libsamplerate midi mp3 soundtouch twolame vamp vorbis"

MY_PV=$(replace_version_separator 3 -)
MY_P="${PN}-src-${MY_PV}-beta"
MY_T="${PN}-minsrc-${MY_PV}-beta"
DESCRIPTION="Free crossplatform audio editor"
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_T}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
RESTRICT="test"

COMMON_DEPEND="x11-libs/wxGTK:2.8[X]
	>=app-arch/zip-2.3
	>=media-libs/libsndfile-1.0.0
	dev-libs/expat
	libsamplerate? ( >=media-libs/libsamplerate-0.1.2 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	mp3? ( >=media-libs/libmad-0.14.2b )
	flac? ( >=media-libs/flac-1.2.0[cxx] )
	id3tag? ( media-libs/libid3tag )
	soundtouch? ( >=media-libs/libsoundtouch-1.3.1 )
	vamp? ( >=media-libs/vamp-plugin-sdk-2.0 )
	twolame? ( media-sound/twolame )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20080617 )
	alsa? ( media-libs/alsa-lib )
	jack? ( >=media-sound/jack-audio-connection-kit-0.103.0 )"
# Crashes at  startup here...
#	lv2? ( >=media-libs/slv2-0.6.0 )
# Disabled upstream ATM
#  ladspa? ( >=media-libs/liblrdf-0.4.0 )

RDEPEND="${COMMON_DEPEND}
	mp3? ( >=media-sound/lame-3.70 )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.3.12-automagic.patch"
	epatch "${FILESDIR}/${PN}-1.3.12-gcc45.patch"
	AT_M4DIR="${S}/m4" eautoreconf
}

src_configure() {
	WX_GTK_VER="2.8"
	need-wxwidgets unicode

	# * always use system libraries if possible
	# * options listed in the order that configure --help lists them
	# * if libsamplerate not requested, use libresample instead.
	econf \
		--enable-unicode \
		--enable-nyquist \
		$(use_enable ladspa) \
		--with-libsndfile=system \
		--with-expat=system \
		$(use_with libsamplerate) \
		$(use_with !libsamplerate libresample) \
		$(use_with vorbis libvorbis) \
		$(use_with mp3 libmad) \
		$(use_with flac libflac) \
		$(use_with id3tag libid3tag) \
		$(use_with soundtouch) \
		$(use_with vamp libvamp) \
		$(use_with twolame libtwolame) \
		$(use_with ffmpeg) \
		$(use_with midi) \
		$(use_with alsa) \
		$(use_with jack)
}

# $(use_with lv2 slv2) \
# $(use_with ladspa liblrdf) \

src_install() {
	emake DESTDIR="${D}" install || die

	# Remove bad doc install
	rm -rf "${D}"/usr/share/doc

	# Install our docs
	dodoc README.txt
}
