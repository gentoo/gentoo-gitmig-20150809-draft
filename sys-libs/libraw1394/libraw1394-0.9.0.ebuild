# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libraw1394/libraw1394-0.9.0.ebuild,v 1.12 2004/01/12 22:38:30 mholzer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem's raw1394 user space interface."
HOMEPAGE="http://sourceforge.net/projects/libraw1394/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"
RESTRICT="nomirror"
IUSE=""
SLOT="0"
LICENSE="LGPL-2.1 | GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/libraw_gcc33_fix
}

src_compile() {
	econf || die
	emake || die

	# DevFS should create this automatically
#	if [ ! -f /dev/raw1394 ]
#	then
#		emake dev
#	fi
}

src_install () {
	make DESTDIR=${D} install || die
}
