# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.0.0.ebuild,v 1.1 2008/01/18 01:09:28 ingmar Exp $

EAPI="1"

KMNAME=kdetoys
inherit kde4-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

COMMON_DEPEND=">=app-misc/strigi-0.5.7
	|| ( >=kde-base/kscreensaver-${PV}:${SLOT}
		    >=kde-base/kdebase-${PV}:${SLOT} )"
DEPEND="${DEPEND} ${COMMON_DEPEND}"
RDEPEND="${RDEPEND} ${COMMON_DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kde Plasma)"

	kde4-base_src_compile
}
