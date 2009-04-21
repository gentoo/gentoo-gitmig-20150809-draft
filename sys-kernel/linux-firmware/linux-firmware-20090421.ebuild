# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-firmware/linux-firmware-20090421.ebuild,v 1.1 2009/04/21 18:39:18 gregkh Exp $


DESCRIPTION="Linux firmware files"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/dwmw2/firmware"
SRC_URI="mirror://kernel/linux/kernel/people/dwmw2/firmware/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /lib/firmware
	cp -R "${S}/"* "${D}lib/firmware/" || die "Install failed!"
}

