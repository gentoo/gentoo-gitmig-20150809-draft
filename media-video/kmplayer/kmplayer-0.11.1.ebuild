# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.11.1.ebuild,v 1.1 2009/05/28 12:44:48 scarabeus Exp $

EAPI="2"

inherit kde4-base

MY_P="${P/_/-}"
DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend."
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://${PN}.kde.org/pkgs/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="cairo doc npp"

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
	!${CATEGORY}/${PN}:0
	!${CATEGORY}/${PN}:4.1
	media-video/mplayer"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# remove duplicate icons (only app icon that is already in oxygen)
	sed -i \
		-e "/add_subdirectory(icons)/ s/^/#DONOTINSTALL /" \
		CMakeLists.txt || die "removing icons failed"
	# install handbook only when requested
	if ! use doc; then
		sed -i \
			-e "/add_subdirectory(doc)/ s/^/#DONOTINSTALL /" \
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
