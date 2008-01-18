# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-4.0.0.ebuild,v 1.1 2008/01/18 00:53:29 ingmar Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="KSysguard is a network enabled task manager and system monitor application, with the additional functionality of top."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook lm_sensors test"

COMMONDEPEND="
	>=kde-base/kdebase-data-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	x11-libs/libXrender
	x11-libs/libXres
	lm_sensors? ( sys-apps/lm_sensors )"
DEPEND="${COMMONDEPEND}
	x11-proto/renderproto"
RDEPEND="${COMMONDEPEND}
	>=kde-base/plasma-${PV}:${SLOT}"

KMEXTRA="libs/ksysguard/"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with lm_sensors Sensors)"
	kde4-meta_src_compile
}

src_test() {
	sed -e '/guitest/s/^/#DONOTTEST/' \
		-i "${S}"/libs/ksysguard/tests/CMakeLists.txt
	kde4-meta_src_test
}
