# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem's raw1394 user space interface."
HOMEPAGE="http://sourceforge.net/projects/libraw1394/"
LICENSE="LGPL"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/libraw1394/${PN}_${PV}.tar.gz"
S=${WORKDIR}/${P}

DEPEND=""
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="x86 ppc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
