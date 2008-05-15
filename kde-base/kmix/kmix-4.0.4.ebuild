# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmix/kmix-4.0.4.ebuild,v 1.1 2008/05/15 23:57:36 ingmar Exp $

EAPI="1"

KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="KDE mixer gui"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug htmlhandbook"

DEPEND="
	>=kde-base/plasma-${PV}:${SLOT}
	alsa? ( >=media-libs/alsa-lib-1.0.14a )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)"
	kde4-meta_src_compile
}
