# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aldo/aldo-0.0.11.ebuild,v 1.1 2003/06/08 17:41:27 avenj Exp $

DESCRIPTION="ALDO is a morse tutor."
HOMEPAGE="http://aldo.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	make libs || die
	make aldo || die
}

src_install() {
	mkdir -p ${D}/usr/bin
	cp aldo ${D}/usr/bin
	dodoc README* TODO VERSION AUTHORS ChangeLog
}
