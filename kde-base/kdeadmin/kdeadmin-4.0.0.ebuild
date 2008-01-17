# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-4.0.0.ebuild,v 1.1 2008/01/17 23:39:55 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE admin module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook lilo"
LICENSE="GPL-2 LGPL-2"

RDEPEND="virtual/cron
	|| ( >=kde-base/kdebase-${PV}:${SLOT} >=kde-base/knotify-${PV}:${SLOT} )"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_lilo-config=$(use lilo && echo TRUE || echo FALSE)
		-DLILO_EXECUTABLE=TRUE"

	kde4-base_src_compile
}
