# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usbview/usbview-1.0-r1.ebuild,v 1.21 2005/01/03 07:33:10 corsair Exp $

DESCRIPTION="Display the topology of devices on the USB bus"
HOMEPAGE="http://www.kroah.com/linux-usb/"
SRC_URI="http://www.kroah.com/linux-usb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ppc64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	econf || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
