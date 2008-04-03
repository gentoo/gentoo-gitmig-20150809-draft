# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.0.3.ebuild,v 1.1 2008/04/03 21:35:57 philantrop Exp $

EAPI="1"

KMNAME=kdetoys
inherit kde4-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"

DEPEND=">=app-misc/strigi-0.5.7
	>=kde-base/kscreensaver-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kde Plasma)"

	kde4-base_src_compile
}
