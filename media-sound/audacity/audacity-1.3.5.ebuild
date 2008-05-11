# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.3.5.ebuild,v 1.1 2008/05/11 18:14:45 aballier Exp $

inherit eutils wxwidgets autotools

IUSE="alsa flac id3tag jack ladspa libsamplerate mp3 soundtouch twolame vamp vorbis"

MY_P="${PN}-src-${PV}"
#MY_PA_P="pa_stable_v19_20071207"
DESCRIPTION="Free crossplatform audio editor"
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
#	http://www.portaudio.com/archives/${MY_PA_P}.tar.gz
#	mirror://gentoo/${P}-portaudio-cvs-rev1.7.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
RESTRICT="test"

COMMON_DEPEND="=x11-libs/wxGTK-2.8*
	>=app-arch/zip-2.3
	dev-libs/expat
	>=media-libs/libsndfile-1.0.0
	alsa? ( media-libs/alsa-lib )
	jack? ( >=media-sound/jack-audio-connection-kit-0.103.0 )
	soundtouch? ( >=media-libs/libsoundtouch-1.3.1 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	mp3? ( >=media-libs/libmad-0.14.2b )
	id3tag? ( media-libs/libid3tag )
	flac? ( media-libs/flac )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.2 )
	vamp? ( media-libs/vamp-plugin-sdk )
	twolame? ( media-sound/twolame )"
RDEPEND="${COMMON_DEPEND}
	mp3? ( >=media-sound/lame-3.70 )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}-beta"

pkg_setup() {
	if use flac && ! built_with_use --missing true media-libs/flac cxx; then
		eerror "To build ${PN} with flac support you need the C++ bindings for flac."
		eerror "Please enable the cxx USE flag for media-libs/flac"
		die "Missing FLAC C++ bindings."
	fi
}

src_unpack() {
	unpack ${A}

#	einfo "Updating portaudio-v19 snapshot to ${MY_PA_P}"
#	rm -r "${S}/lib-src/portaudio-v19" || die
#	mv "${WORKDIR}/portaudio" "${S}/lib-src/portaudio-v19" || die

	cd "${S}"

#	cd lib-src/portaudio-v19
#	epatch "${WORKDIR}/${P}-portaudio-cvs-rev1.7.patch"

#	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.3.4-automagic.patch"
	epatch "${FILESDIR}/${P}-cflags_with_non_standard_macros.patch"
	epatch "${FILESDIR}/${P}-libtool22.patch"
	eautoreconf
}

src_compile() {
	WX_GTK_VER="2.8"
	need-wxwidgets unicode

	econf \
		--with-libexpat=system \
		--enable-unicode \
		$(use_with ladspa) \
		$(use_with vorbis libvorbis) \
		$(use_with mp3 libmad) \
		$(use_with id3tag libid3tag) \
		$(use_with flac libflac) \
		$(use_enable vamp) \
		$(use_with twolame libtwolame) \
		$(use_with soundtouch) \
		$(use_with libsamplerate) \
		$(use_with alsa) \
		$(use_with jack)

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Remove bad doc install
	rm -rf "${D}"/usr/share/doc

	# Install our docs
	dodoc README.txt
}
