# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knemo/knemo-0.2.0.ebuild,v 1.1 2004/08/01 20:36:17 centic Exp $

inherit kde

DESCRIPTION="KNemo - the KDE Network Monitor"
SRC_URI="http://kde-apps.org/content/files/12956-${P}.tar.bz2"
HOMEPAGE="http://kde-apps.org/content/show.php?content=12956"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="wifi"

RDEPEND="sys-apps/net-tools
	wifi? ( net-wireless/wireless-tools )"
need-kde 3.2

pkg_postinst() {
	einfo ""
	einfo "KNemo is not an executable but an KDED service. Therefore it has to"
	einfo "be started using Control Center/KDE Components/Service Manager."
	einfo ""
}

