# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-1.0_beta1-r2.ebuild,v 1.11 2008/04/25 13:33:57 ingmar Exp $

inherit kde autotools

MY_PV=${PV}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://kde-bluetooth.sourceforge.net/"
SRC_URI="mirror://sourceforge/kde-bluetooth/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~hppa ppc sparc x86"
IUSE="irmc"

DEPEND=">=dev-libs/openobex-1.1
	>=net-wireless/bluez-libs-2.15
	>=media-libs/libvorbis-1.0
	irmc? ( || ( >=kde-base/kitchensync-3.4_beta1 >=kde-base/kdepim-3.4_beta1 ) )"

RDEPEND="${DEPEND}
	|| ( ( =kde-base/kdialog-3.5* =kde-base/konqueror-3.5* )
		=kde-base/kdebase-3.5* )
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

	local myconf="--without-xmms $(use_enable irmc irmcsynckonnector)"

	kde_src_compile
}

pkg_postinst() {
	einfo 'This new version of kde-bluetooth provides a replacement for the'
	einfo 'standard bluepin program "kbluepin". If you want to use this version,'
	einfo 'you have to edit "/etc/bluetooth/hcid.conf" and change the line'
	einfo '"pin_helper oldbluepin;" to "pin_helper /usr/lib/kdebluetooth/kbluepin;".'
	einfo 'Then restart hcid to make the change take effect.'
}
