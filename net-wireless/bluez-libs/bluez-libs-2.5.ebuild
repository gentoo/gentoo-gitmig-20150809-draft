# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-libs/bluez-libs-2.5.ebuild,v 1.1 2004/03/29 02:06:19 liquidx Exp $

DESCRIPTION="Bluetooth Userspace Libraries"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
DEPEND=""

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
