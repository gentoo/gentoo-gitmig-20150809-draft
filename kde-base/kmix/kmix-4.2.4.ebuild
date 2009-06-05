# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmix/kmix-4.2.4.ebuild,v 1.2 2009/06/05 00:11:52 alexxy Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE mixer gui"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug +handbook"

DEPEND="
	alsa? ( >=media-libs/alsa-lib-1.0.14a )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa Alsa)"

	kde4-meta_src_configure
}
