# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klinkstatus/klinkstatus-4.0.4.ebuild,v 1.1 2008/05/15 23:51:57 ingmar Exp $

EAPI="1"

KMNAME=kdewebdev
inherit kde4-meta

DESCRIPTION="KDE web development - link validity checker"
KEYWORDS="~amd64 ~x86"
IUSE="debug tidy"

HOMEPAGE="http://www.kde.org/"

DEPEND="
	tidy? ( app-text/htmltidy )"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_quanta=OFF
		$(cmake-utils_use_with tidy LibTidy)"

	kde4-meta_src_compile
}
