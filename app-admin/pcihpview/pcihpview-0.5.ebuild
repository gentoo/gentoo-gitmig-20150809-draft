# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pcihpview/pcihpview-0.5.ebuild,v 1.1 2004/03/16 18:26:31 gregkh Exp $

DESCRIPTION="Display all PCI Hotplug devices in the system"
SRC_URI="http://www.kroah.com/linux/hotplug/${P}.tar.gz"
HOMEPAGE="http://www.kroah.com/linux/hotplug"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	econf
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
