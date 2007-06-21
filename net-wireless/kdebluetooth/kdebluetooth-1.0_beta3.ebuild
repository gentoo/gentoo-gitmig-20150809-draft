# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-1.0_beta3.ebuild,v 1.3 2007/06/21 13:20:35 gustavoz Exp $

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
	"

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

pkg_postinst() {
	einfo 'This version of kde-bluetooth provides a replacement for the'
	einfo 'standard bluepin program "kbluepin". If you want to use this version,'
	einfo 'you have to edit "/etc/bluetooth/hcid.conf" and change the line'
	einfo '"pin_helper oldbluepin;" to "pin_helper /usr/lib/kdebluetooth/kbluepin;".'
	einfo 'Then restart hcid to make the change take effect.'
}

