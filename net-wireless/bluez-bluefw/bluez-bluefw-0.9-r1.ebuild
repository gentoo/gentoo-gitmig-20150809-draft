# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-bluefw/bluez-bluefw-0.9-r1.ebuild,v 1.9 2005/02/22 11:03:23 blubb Exp $

inherit eutils

DESCRIPTION="Bluetooth USB Firmware Downloader"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="sys-apps/hotplug
	>=net-wireless/bluez-libs-2.2"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-kernel2.6.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog
}
