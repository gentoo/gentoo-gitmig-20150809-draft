# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kweather/kweather-4.2.1.ebuild,v 1.1 2009/03/04 22:33:31 alexxy Exp $

EAPI="2"

KMNAME="kdetoys"
inherit kde4-meta

DESCRIPTION="KDE weather status display"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/plasma-workspace-${PV}:${SLOT}
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Plasma=ON"

	kde4-base_src_configure
}
