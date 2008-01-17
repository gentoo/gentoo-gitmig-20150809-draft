# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys/kdetoys-4.0.0.ebuild,v 1.1 2008/01/17 23:55:50 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE toys module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"
LICENSE="GPL-2 LGPL-2"

RESTRICT="test"

COMMON_DEPEND=">=app-misc/strigi-0.5.7
	|| ( >=kde-base/kdebase-${PV}:${SLOT}
		( >=kde-base/kscreensaver-${PV}:${SLOT} >=kde-base/plasma-${PV}:${SLOT} ) )"
DEPEND="${DEPEND} ${COMMON_DEPEND}"
RDEPEND="${RDEPEND} ${COMMON_DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Plasma=ON"

	kde4-base_src_compile
}
