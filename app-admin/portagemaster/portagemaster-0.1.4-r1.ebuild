# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/portagemaster/portagemaster-0.1.4-r1.ebuild,v 1.10 2002/12/25 23:47:02 mholzer Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A java portage browser and installer."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://portagemaster.sourceforge.net"
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND=""
RDEPEND="virtual/jre"

src_install() {
	dodir /opt/${PN}
	cp portagemaster-${PV}.jar ${D}/opt/${PN}
	
	into /usr
	dobin portagemaster
	ln -s /opt/${PN}/portagemaster-${PV}.jar ${D}/opt/${PN}/portagemaster.jar
}
