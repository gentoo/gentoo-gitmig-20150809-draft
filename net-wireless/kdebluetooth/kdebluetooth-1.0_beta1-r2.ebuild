# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-1.0_beta1-r2.ebuild,v 1.2 2006/04/25 16:28:38 mrness Exp $

inherit kde autotools

MY_PV=${PV}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://kde-bluetooth.sourceforge.net/"
SRC_URI="mirror://sourceforge/kde-bluetooth/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="xmms irmc"

DEPEND=">=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2.15
	>=media-libs/libvorbis-1.0
	xmms? ( >=media-sound/xmms-1.2.10 )
	irmc? ( || ( >=kde-base/kitchensync-3.4_beta1 >=kde-base/kdepim-3.4_beta1 ) )"

RDEPEND="${DEPEND}
	|| ( ( kde-base/kdialog kde-base/konqueror )  kde-base/kdebase )
	net-wireless/bluez-utils"

PATCHES="${FILESDIR}/${P}-gcc41.patch
	${FILESDIR}/${P}-kde3.5.2.patch
	${FILESDIR}/${P}-openobex-1.1.patch"

need-kde 3

src_unpack() {
	kde_src_unpack

	eaclocal && eautoconf || die "autotools failed"
}

src_compile() {
	# Change defaults to match our bluez-utils setup
	sed -i -e 's,/etc/init\.d/bluez-utils,/etc/init\.d/bluetooth,' \
		"${S}/kdebluetooth/kbluetoothd/kcm_btpaired/pairedtab.cpp" || die

	local myconf="$(use_with xmms) $(use_enable irmc irmcsynckonnector)"

	kde_src_compile
}

pkg_postinst() {
	einfo 'This new version of kde-bluetooth provides a replacement for the'
	einfo 'standard bluepin program "kbluepin". If you want to use this version,'
	einfo 'you have to edit "/etc/bluetooth/hcid.conf" and change the line'
	einfo '"pin_helper oldbluepin;" to "pin_helper /usr/lib/kdebluetooth/kbluepin;".'
	einfo 'Then restart hcid to make the change take effect.'
	einfo ''
	einfo 'The bemused server (avaible with the "xmms" USE flag enabled) only works with'
	einfo 'Symbian OS phones'
}
