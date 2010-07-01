# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knemo/knemo-0.6.3.ebuild,v 1.1 2010/07/01 20:37:41 spatz Exp $

EAPI=2
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

DEPEND=">=kde-base/systemsettings-${KDE_MINIMAL}
	net-wireless/wireless-tools
	sys-apps/net-tools
	dev-libs/libnl"

DOCS="AUTHORS ChangeLog README TODO"
