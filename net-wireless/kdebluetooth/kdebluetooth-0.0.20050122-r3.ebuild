# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-0.0.20050122-r3.ebuild,v 1.2 2005/02/02 20:20:23 centic Exp $

inherit kde eutils

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://kde-bluetooth.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~motaboy/files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="xmms irmc"

DEPEND=">=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2.7
	>=media-libs/libvorbis-1.0
	xmms? ( >=media-sound/xmms-1.2.10 )
	irmc? ( || ( >=kde-base/kitchensync-3.4_beta1 >=kde-base/kdepim-3.4_beta1 ) )"

RDEPEND="|| ( kde-base/kdialog kde-base/kdebase )"

need-kde 3

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-compile.patch
}

src_compile() {
	kde_src_compile myconf
	myconf="$myconf `use_with xmms` `use_enable irmc irmcsynckonnector`"
	kde_src_compile configure make
}

pkg_postinst() {
	einfo 'This new version of kde-bluetooth provides a replacement for the'
	einfo 'standard bluepin program "kbluepin". If you want to use this version,'
	einfo 'you have to edit "/etc/bluetooth/hcid.conf" and change the line'
	einfo '"pin_helper oldbluepin;" to "pin_helper /usr/bin/kbluepin;".'
	einfo 'Then restart hcid to make the change take effect.'
	einfo ''
	einfo 'The bemused server (avaible with the "xmms" USE flag enabled) only works with'
	einfo 'Symbian OS phones'
}
