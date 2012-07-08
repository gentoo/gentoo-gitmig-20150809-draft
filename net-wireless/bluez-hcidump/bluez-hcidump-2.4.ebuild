# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-hcidump/bluez-hcidump-2.4.ebuild,v 1.4 2012/07/08 12:36:10 hwoarang Exp $

EAPI=4

DESCRIPTION="Bluetooth HCI packet analyzer"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ppc ~x86"
IUSE=""

RDEPEND=">=net-wireless/bluez-4.98"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-arch/xz-utils"

DOCS=( AUTHORS ChangeLog README )
