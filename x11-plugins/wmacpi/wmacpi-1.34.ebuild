# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpi/wmacpi-1.34.ebuild,v 1.2 2003/06/26 00:35:51 vapier Exp $

DESCRIPTION="WMaker DockApp: ACPI status monitor for laptops"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11"

src_compile() {
	use apm && use acpi && eerror "APM and ACPI is in USE ... defaulting to ACPI"
	use apm || use acpi || eerror "Neither APM or ACPI is in USE ... defaulting to ACPI"
	[ `use acpi` ] \
		&& export CFLAGS="${CFLAGS} -DACPI" \
		|| export CFLAGS="${CFLAGS} -DAPM"
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin wmacpi
	dodoc AUTHORS ChangeLog README
}
