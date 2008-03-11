# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-4.0.1.ebuild,v 1.1 2008/03/11 00:05:59 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE web development - Quanta"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook tidy"
LICENSE="GPL-2 LGPL-2"

DEPEND="
	tidy? ( app-text/htmltidy )"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_quanta=OFF
		$(cmake-utils_use_with tidy LibTidy)"
	kde4-base_src_compile
}
