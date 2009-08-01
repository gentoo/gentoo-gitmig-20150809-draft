# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-1.7.3.ebuild,v 1.2 2009/08/01 06:37:24 ssuominen Exp $

EAPI=2

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
	alsa? ( media-libs/alsa-lib
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
}

src_prepare() {
	epatch "${FILESDIR}/rosegarden-1.6.1-asneeded.patch" \
		"${FILESDIR}/rosegarden-1.6.1.desktop.diff"
}

src_configure() {
	tc-export CC CXX LD

	# cmake is stupid, very very stupid.
	sed -i -e 's:CMAKE_CXX_FLAGS_\(RELEASE\|RELWITHDEBINFO\|DEBUG\).*".*"):CMAKE_CXX_FLAGS_\1 "'"${CXXFLAGS}"'"):' \
		CMakeLists.txt || die "unable to sanitise CXXFLAGS"

	mycmakeargs="$(cmake-utils_use_want alsa SOUND)
		$(cmake-utils_use_want jack JACK)
		$(cmake-utils_use_want dssi DSSI)
		$(cmake-utils_use_want lirc LIRC)"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS README TRANSLATORS
}
