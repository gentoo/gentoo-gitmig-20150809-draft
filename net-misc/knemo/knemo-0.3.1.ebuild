# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knemo/knemo-0.3.1.ebuild,v 1.3 2005/03/25 20:51:48 carlo Exp $

inherit kde

DESCRIPTION="KNemo - the KDE Network Monitor"
SRC_URI="http://www.eris23.de/knemo/${P}.tar.bz2"
HOMEPAGE="http://kde-apps.org/content/show.php?content=12956"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"
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