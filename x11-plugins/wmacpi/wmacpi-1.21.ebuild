# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpi/wmacpi-1.21.ebuild,v 1.4 2003/02/23 21:39:37 vapier Exp $

DESCRIPTION="WMaker DockApp: ACPI status monitor for laptops"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/${P}.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11"

S="${WORKDIR}/wmapm-${PV}"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	newbin wmapm wmacpi
	dodoc AUTHORS ChangeLog COPYING README
}
