# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/phonon-kde/phonon-kde-4.5.1.ebuild,v 1.2 2010/09/06 04:50:57 reavertm Exp $

EAPI="3"

KMNAME="kdebase-runtime"
KMMODULE="phonon"
inherit kde4-meta

DESCRIPTION="Phonon KDE Integration"
HOMEPAGE="http://phonon.kde.org"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE="alsa debug +xine"

DEPEND="
	>=media-sound/phonon-4.3.80[xine?]
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_tests=OFF
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with xine)
	)

	kde4-meta_src_configure
}
