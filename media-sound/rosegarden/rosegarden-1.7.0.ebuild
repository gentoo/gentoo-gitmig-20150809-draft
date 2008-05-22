# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-1.7.0.ebuild,v 1.1 2008/05/22 22:01:46 aballier Exp $

inherit eutils kde-functions cmake-utils

MY_PV="${PV/_rc*/}"
#MY_PV="${MY_PV/4./}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/rosegarden/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa debug jack dssi lirc"

RDEPEND="
	alsa? ( >=media-libs/alsa-lib-1.0
		jack? ( >=media-sound/jack-audio-connection-kit-0.77 )
	)
	>=media-libs/ladspa-sdk-1.0
	>=media-libs/ladspa-cmt-1.14
	dssi? ( >=media-libs/dssi-0.4 )
	lirc? ( >=app-misc/lirc-0.7 )
	>=media-libs/liblrdf-0.3
	>=sci-libs/fftw-3.0.0
	>=media-libs/liblo-0.7"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15
	>=dev-util/cmake-2.4.2"

need-kde 3.5

pkg_setup() {
	if ! use alsa && use jack; then
		ewarn "If you want JACK support you also need to enable"
		ewarn "ALSA support, or the whole sound support will be"
		ewarn "disabled."
	fi

	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror ""
		eerror "To be able to build Rose Garden with ALSA support you need"
		eerror "to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/rosegarden-1.6.1-asneeded.patch" \
		"${FILESDIR}/rosegarden-1.6.1.desktop.diff"
}

src_compile() {
	tc-export CC CXX LD

	# cmake is stupid, very very stupid.
	sed -i -e 's:CMAKE_CXX_FLAGS_\(RELEASE\|RELWITHDEBINFO\|DEBUG\).*".*"):CMAKE_CXX_FLAGS_\1 "'"${CXXFLAGS}"'"):' \
		CMakeLists.txt || die "unable to sanitise CXXFLAGS"

	mycmakeargs="$(cmake-utils_use_want alsa SOUND)
		$(cmake-utils_use_want jack JACK)
		$(cmake-utils_use_want dssi DSSI)
		$(cmake-utils_use_want lirc LIRC)"
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS README TRANSLATORS
}
