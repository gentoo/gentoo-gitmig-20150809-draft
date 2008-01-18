# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kig/kig-4.0.0.ebuild,v 1.1 2008/01/18 00:03:01 philantrop Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE Interactive Geometry tool"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook kig-scripting"

COMMONDEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )"
DEPEND="${DEPEND} ${COMMONDEPEND}"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kig-scripting BoostPython)"

	kde4-meta_src_compile
}
