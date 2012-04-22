# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-netstoremanager/leechcraft-netstoremanager-0.5.65.ebuild,v 1.1 2012/04/22 13:11:37 maksbotan Exp $

EAPI=4

inherit leechcraft

DESCRIPTION="LeechCraft plugin for supporting and managing Internet data storages like Yandex.Disk"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+yandexdisk"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"

src_configure(){
	local mycmakeargs="
		$(cmake-utils_use_enable yandexdisk ENABLE_NETSTOREMANAGER_YANDEXDISK)
	"

	cmake-utils_src_configure
}
