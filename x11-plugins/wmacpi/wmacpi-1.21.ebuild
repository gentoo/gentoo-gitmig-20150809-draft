# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpi/wmacpi-1.21.ebuild,v 1.1 2002/11/22 22:21:02 vapier Exp $

DESCRIPTION="WMaker DockApp: ACPI status monitor for laptops"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/${P}.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11"

S="${WORKDIR}/wmapm-${PV}"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	newbin wmapm wmacpi
	dodoc AUTHORS ChangeLog COPYING README
}
