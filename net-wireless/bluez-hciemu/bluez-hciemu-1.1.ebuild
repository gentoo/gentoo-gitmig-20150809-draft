# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-hciemu/bluez-hciemu-1.1.ebuild,v 1.1 2005/03/08 15:35:47 liquidx Exp $

DESCRIPTION="bluetooth HCI emulator"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="=dev-libs/glib-1.2*
	>=net-wireless/bluez-libs-2.2"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README AUTHORS ChangeLog
}
