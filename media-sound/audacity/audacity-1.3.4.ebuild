# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.3.4.ebuild,v 1.8 2007/12/04 17:40:02 armin76 Exp $

inherit eutils wxwidgets

IUSE="flac id3tag ladspa libsamplerate mp3 soundtouch twolame unicode vamp vorbis"

MY_P="${PN}-src-${PV}"
DESCRIPTION="Free crossplatform audio editor"
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
RESTRICT="test"

DEPEND="=x11-libs/wxGTK-2.6*
	>=app-arch/zip-2.3
	dev-libs/expat
	>=media-libs/libsndfile-1.0.0
	soundtouch? ( >=media-libs/libsoundtouch-1.3.1 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	mp3? ( >=media-libs/libmad-0.14.2b )
	id3tag? ( media-libs/libid3tag )
	flac? ( media-libs/flac )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.2 )
	vamp? ( media-libs/vamp-plugin-sdk )
	twolame? ( media-sound/twolame )"
RDEPEND="${DEPEND}
	mp3? ( >=media-sound/lame-3.70 )"

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

	cd "${S}"

	epatch "${FILESDIR}/${P}-nolibfailure.patch"
}

src_compile() {
	WX_GTK_VER="2.6"

	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
	fi

	econf \
		--with-libexpat=system \
		$(use_enable unicode) \
		$(use_with ladspa) \
		$(use_with vorbis) \
		$(use_with mp3 libmad) \
		$(use_with id3tag) \
		$(use_with flac libflac) \
		$(use_enable vamp) \
		$(use_with twolame libtwolame) \
		$(use_with soundtouch) \
		$(use_with libsamplerate) \
		|| die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Remove bad doc install
	rm -rf "${D}"/usr/share/doc

	# Install our docs
	dodoc README.txt
}
