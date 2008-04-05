# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-2.0.2.ebuild,v 1.1 2008/04/05 17:10:26 philantrop Exp $

EAPI="1"

KDE_PV="4.0.3"
SLOT="kde-4"
NEED_KDE=":${SLOT}"
inherit kde4-base

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 4."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${KDE_PV}/src/extragear/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="debug plasma"

PREFIX="${KDEDIR}"

RDEPEND="plasma? ( kde-base/plasma:${SLOT} )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4-base_src_compile
}
