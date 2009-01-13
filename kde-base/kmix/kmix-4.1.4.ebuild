# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmix/kmix-4.1.4.ebuild,v 1.1 2009/01/13 22:20:49 alexxy Exp $

EAPI="2"

KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE mixer gui"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug htmlhandbook"

DEPEND="
	media-sound/phonon
	alsa? ( >=media-libs/alsa-lib-1.0.14a )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)"
	kde4-meta_src_configure
}
