# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/granatier/granatier-4.4.0.ebuild,v 1.1 2010/02/09 00:17:15 alexxy Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE Bomberman game"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook gluon"

DEPEND="
	gluon? ( media-libs/gluon )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs+="
		$(cmake-utils_use_with gluon)
	"

	kde4-meta_src_configure
}
