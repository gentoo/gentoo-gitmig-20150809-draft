# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/app-admin/portagemaster/portagemaster-0.1.4.ebuild,v 1.1 2002/06/05 06:45:36 rphillips Exp

S=${WORKDIR}/${PN}
DESCRIPTION="A java portage browser and installer."
SRC_URI="http://portagemaster.sourceforge.net/packages/${P}.tar.bz2"
HOMEPAGE="http://portagemaster.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

RDEPEND="virtual/jre"

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /opt/${PN}
	cp portagemaster-${PV}.jar ${D}/opt/${PN}
	
	into /usr
	dobin portagemaster
	ln -s /opt/${PN}/portagemaster-${PV}.jar ${D}/opt/${PN}/portagemaster.jar
}
