# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ap-utils/ap-utils-1.0.5.ebuild,v 1.3 2003/02/13 15:27:31 vapier Exp $

DESCRIPTION="Wireless Access Point Utilites for Unix"
HOMEPAGE="http://ap-utils.polesye.net/"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
DEPEND=">=bison-1.34"
RDEPEND=""

src_compile() {
	econf --build=${CHOST} # implicit || die
	emake || die
}

src_install () {
	einstall || die
}
