# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knemo/knemo-0.4.0.ebuild,v 1.4 2006/06/08 18:52:25 squinky86 Exp $

inherit kde eutils

DESCRIPTION="KNemo - the KDE Network Monitor"
SRC_URI="http://www.eris23.de/knemo/${P}.tar.bz2"
HOMEPAGE="http://kde-apps.org/content/show.php?content=12956"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="wifi"

RDEPEND="kernel_linux? ( sys-apps/net-tools )
	wifi? ( net-wireless/wireless-tools )"
need-kde 3.4

pkg_postinst() {
	echo
	einfo "KNemo is not an executable but an KDED service. Therefore it has to"
	einfo "be started using Control Center/KDE Components/Service Manager."
	echo
}
