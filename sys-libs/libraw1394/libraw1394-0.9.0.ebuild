# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libraw1394/libraw1394-0.9.0.ebuild,v 1.15 2004/02/09 10:56:28 aliz Exp $

inherit gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem's raw1394 user space interface."
HOMEPAGE="http://sourceforge.net/projects/libraw1394/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"
RESTRICT="nomirror"
IUSE=""
SLOT="0"
LICENSE="LGPL-2.1 | GPL-2"
KEYWORDS="x86 ppc sparc ~amd64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/libraw_gcc33_fix
}

src_compile() {
	gnuconfig_update

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
