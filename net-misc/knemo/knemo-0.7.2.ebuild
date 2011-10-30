# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knemo/knemo-0.7.2.ebuild,v 1.2 2011/10/30 10:41:52 dilfridge Exp $

EAPI=4
KDE_LINGUAS="ar bg br cs cy da de el en_GB eo es et fi fr ga gl hr hu is it ja
ka km lt ms nb nds nl pl pt pt_BR ro ru rw sk sr sv tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KNemo - the KDE Network Monitor"
HOMEPAGE="http://kde-apps.org/content/show.php?content=12956"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/12956-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep systemsettings)
	net-wireless/wireless-tools
	sys-apps/net-tools
	dev-libs/libnl:1.1
	x11-libs/qt-sql[sqlite]
"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog README"
