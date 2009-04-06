# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.11.0a.ebuild,v 1.5 2009/04/06 11:56:28 scarabeus Exp $

EAPI="2"

inherit kde4-base

MY_P="${P/_/-}"
DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend."
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://${PN}.kde.org/pkgs/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4.1"
IUSE="cairo htmlhandbook npp"

DEPEND="
	>=dev-libs/expat-2.0.1
	|| ( media-sound/phonon x11-libs/qt-phonon )
	x11-libs/libXv
	cairo? ( x11-libs/cairo )
	npp? (
		>=dev-libs/nspr-4.6.7
		x11-libs/gtk+
	)
"
RDEPEND="${DEPEND}
	!media-video/kmplayer:0
	media-video/mplayer"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"$FILESDIR/${PV}-fix_linking.patch"
	"$FILESDIR/${PV}-npp.patch"
)

src_prepare() {
	# fixup icon install
	sed -i \
		-e "s:add_subdirectory(icons):#add_subdirectory(icons):g" \
		CMakeLists.txt || die "removing icons failed"
	# fixup htmlhandbook
	if ! use htmlhandbook; then
		sed -i \
			-e "s:add_subdirectory(doc):#add_subdirectory(doc):g" \
			CMakeLists.txt || die "removing docs failed"
	else
		# fix the install dir for docs
		sed -i \
			-e "s:\${HTML_INSTALL_DIR}/en:\${HTML_INSTALL_DIR}/en/${PF}:g" \
			doc/CMakeLists.txt || die "fixing target dir failed"
	fi
	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with cairo CAIRO)
		$(cmake-utils_use_with npp NPP)"
	kde4-base_src_configure
}
