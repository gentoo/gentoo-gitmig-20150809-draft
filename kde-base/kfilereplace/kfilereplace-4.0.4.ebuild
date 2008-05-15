# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfilereplace/kfilereplace-4.0.4.ebuild,v 1.1 2008/05/15 23:33:36 ingmar Exp $

EAPI="1"

KMNAME=kdewebdev
inherit kde4-meta

DESCRIPTION="KDE web development - powerful search and replace in multiple files"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.kde.org/"
IUSE="debug htmlhandbook tidy"

DEPEND="tidy? ( app-text/htmltidy )"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_quanta=OFF
		$(cmake-utils_use_with tidy LibTidy)"

	kde4-meta_src_compile
}
