# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knewsticker/knewsticker-4.0.5.ebuild,v 1.1 2008/06/05 22:04:52 keytoaster Exp $

EAPI="1"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="Plasma widget: rss news ticker"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/plasma-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs} -DWITH_Plasma=ON"

	kde4-meta_src_compile
}
