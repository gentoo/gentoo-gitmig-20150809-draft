# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-2.0.2-r1.ebuild,v 1.3 2009/08/14 08:34:17 ssuominen Exp $

EAPI="2"

KDE_PV="4.2.0"
SLOT="2"
KDE_LINGUAS="ca cs el es et fr ga gl it nb nl pt ru sv tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 4."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${KDE_PV}/src/extragear/${P}-kde${KDE_PV}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="debug plasma"

RDEPEND="plasma? ( >=kde-base/plasma-workspace-${KDE_MINIMAL} )"
DEPEND="${RDEPEND}
		!net-p2p/kmldonkey:4.1
		sys-devel/gettext"

S=${WORKDIR}/${P}-kde${KDE_PV}

PATCHES=( "${FILESDIR}/${P}-gcc44.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4-base_src_configure
}
