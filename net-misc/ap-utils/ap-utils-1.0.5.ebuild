# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ap-utils/ap-utils-1.0.5.ebuild,v 1.1 2002/09/15 15:59:04 agriffis Exp $

DESCRIPTION="Wireless Access Point Utilites for Unix"
HOMEPAGE="http://ap-utils.polesye.net/"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=bison-1.34"
RDEPEND=""

src_compile() {
	econf --build=${CHOST} # implicit || die
	emake || die
}

src_install () {
	einstall || die
}
