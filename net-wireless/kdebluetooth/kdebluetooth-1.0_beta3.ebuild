# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-1.0_beta3.ebuild,v 1.4 2007/06/22 20:43:25 philantrop Exp $

inherit kde autotools

MY_P="${P/_/-}"
MY_PV="${PV/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
SRC_URI="mirror://sourceforge/kde-bluetooth/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/openobex-1.1
	app-mobilephone/obexftp
	>=dev-libs/dbus-qt3-old-0.70"

RDEPEND="${DEPEND}
	|| ( ( kde-base/kdialog kde-base/konqueror )  kde-base/kdebase )
	>=net-wireless/bluez-libs-3.11
	>=net-wireless/bluez-utils-3.11"

#PATCHES="${FILESDIR}/kdebluetooth-1.0_beta3-as-needed.patch"

need-kde 3

src_unpack() {
	kde_src_unpack
	rm -f "${S}/configure"
}

src_compile() {
	kde_src_compile
}
