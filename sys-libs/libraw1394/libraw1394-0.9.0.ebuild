# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

S=${WORKDIR}/${P}
DESCRIPTION="libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem's raw1394 user space interface."
HOMEPAGE="http://sourceforge.net/projects/libraw1394/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1 | GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die

	if [ ! -f /dev/raw1394 ]
	then
		emake dev
	fi
}

src_install () {
	make DESTDIR=${D} install || die
}
