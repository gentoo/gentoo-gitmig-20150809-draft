# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpi/wmacpi-1.99_p7.ebuild,v 1.4 2004/11/01 20:21:38 gustavoz Exp $

IUSE=""
DESCRIPTION="WMaker DockApp: ACPI status monitor for laptops"
HOMEPAGE="http://himi.org/wmacpi-ng/"
MY_PV="1.99r7"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"
SRC_URI="http://himi.org/wmacpi-ng/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc amd64 -ppc"

DEPEND="virtual/x11
	>=x11-libs/libdockapp-0.4.0-r1"

src_compile()
{
	emake OPT="${CFLAGS}" || die
}

src_install()
{
	# Fix for #60685:
	# acpi and acpi.1 conflict with package sys-apps/acpi
	mv acpi   acpi-batt-status
	mv acpi.1 acpi-batt-status.1

	dobin wmacpi acpi-batt-status
	doman wmacpi.1 acpi-batt-status.1
	dodoc AUTHORS ChangeLog README
}
