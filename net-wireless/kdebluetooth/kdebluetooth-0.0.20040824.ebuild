# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-0.0.20040824.ebuild,v 1.3 2004/09/20 16:48:50 puggy Exp $

inherit kde

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://kde-bluetooth.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~puggy/files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="${IUSE} xmms"

RDEPEND=">=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2.7
	>=media-libs/libvorbis-1.0
	xmms? ( >=media-sound/xmms-1.2.10 )"

DEPEND="${RDEPEND}"

need-kde 3



src_compile() {
	use arts || myconf="${myconf} --without-arts"
	use xmms || myconf="${myconf} --without-xmms"
	econf ${myconf} || die "./configure failed"

	# remove once author has fixed arts bug
	if ! use arts
	then
		sed -e "s/handsfree//" kdebluetooth/Makefile >${T}/Makefile
		mv ${T}/Makefile kdebluetooth/Makefile
	fi
	# end

	emake || die "emake failed"
}



pkg_postinst() {
	einfo 'This new version of kde-bluetooth provides a replacement for the'
	einfo 'standard bluepin program "kbluepin". If you want to use this version,'
	einfo 'you have to edit "/etc/bluetooth/hcid.conf" and change the line'
	einfo '"pin_helper oldbluepin;" to "pin_helper /usr/bin/kbluepin;".'
	einfo 'Then restart hcid to make the change take effect.'
	einfo ''
	einfo 'The bemused server (xmms flag option) only works with series 60'
	einfo 'and above Nokia phones.'
}
