# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpi/wmacpi-1.99_p6.ebuild,v 1.1 2004/08/13 19:32:26 s4t4n Exp $

IUSE=""
DESCRIPTION="WMaker DockApp: ACPI status monitor for laptops"
HOMEPAGE="http://himi.org/wmacpi-ng/"
MY_PV="1.99r6"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"
SRC_URI="http://himi.org/wmacpi-ng/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

DEPEND="virtual/x11"

src_compile()
{
	emake OPT="${CFLAGS}" || die
}

src_install()
{
	dobin wmacpi acpi
	doman wmacpi.1 acpi.1
	dodoc AUTHORS ChangeLog README
}
