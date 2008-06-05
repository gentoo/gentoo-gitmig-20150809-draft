# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lilo-config/lilo-config-4.0.5.ebuild,v 1.1 2008/06/05 22:40:59 keytoaster Exp $

EAPI="1"

KMNAME=kdeadmin
inherit kde4-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_lilo-config=TRUE -DLILO_EXECUTABLE=TRUE"

	kde4-meta_src_compile
}
