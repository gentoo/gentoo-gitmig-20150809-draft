# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpower/wmpower-0.3.0.ebuild,v 1.3 2004/01/04 18:36:48 aliz Exp $

IUSE=""

DESCRIPTION="WMaker DockApp to get (and set) power management status for laptops. Supports both APM and ACPI kernels. Also has direct support for Toshiba hardware."
HOMEPAGE="http://wmpower.sourceforge.net/"
SRC_URI="mirror://sourceforge/wmpower/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/cflags.patch
}

src_install() {
	dodir /usr/bin
	make prefix=${D}/usr install || die
	dodoc AUTHORS COPYING ChangeLog LEGGIMI NEWS README README.compal
}
