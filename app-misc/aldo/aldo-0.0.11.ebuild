# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aldo/aldo-0.0.11.ebuild,v 1.3 2004/03/14 10:48:18 mr_bones_ Exp $

DESCRIPTION="ALDO is a morse tutor."
HOMEPAGE="http://aldo.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""

src_compile() {
	make libs || die
	make aldo || die
}

src_install() {
	mkdir -p ${D}/usr/bin
	cp aldo ${D}/usr/bin
	dodoc README* TODO VERSION AUTHORS ChangeLog
}
