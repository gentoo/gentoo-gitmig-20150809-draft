# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pcihpview/pcihpview-0.5.ebuild,v 1.6 2009/10/11 23:40:59 halcy0n Exp $

DESCRIPTION="Display all PCI Hotplug devices in the system"
HOMEPAGE="http://www.kroah.com/linux/hotplug/"
SRC_URI="http://www.kroah.com/linux/hotplug/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	econf || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
