# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpower/wmpower-0.3.1.ebuild,v 1.6 2004/11/12 23:18:40 s4t4n Exp $

IUSE=""

DESCRIPTION="WMaker DockApp to get (and set) power management status for laptops. Supports both APM and ACPI kernels. Also has special support for Toshiba and Compal hardware."
HOMEPAGE="http://wmpower.sourceforge.net/"
SRC_URI="mirror://sourceforge/wmpower/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/x11"

src_compile()
{
	# override wmpower self-calculated cflags
	econf MY_CFLAGS="${CFLAGS}" || die "Configuration failed"
	emake prefix="/usr/" || die "Compilation failed"
}

src_install()
{
	einstall || die "Installation failed"
	dodoc AUTHORS BUGS COPYING ChangeLog LEGGIMI NEWS README README.compal THANKS TODO
}
