# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-hciemu/bluez-hciemu-1.0.ebuild,v 1.6 2004/02/15 12:35:23 dholm Exp $

DESCRIPTION="bluetooth HCI emulator"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
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
