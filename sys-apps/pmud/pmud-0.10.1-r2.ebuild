# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pmud/pmud-0.10.1-r2.ebuild,v 1.15 2003/06/23 00:06:24 pylon Exp $

IUSE="X"

S=${WORKDIR}/${P}

DESCRIPTION="PowerMac power management utilities"
SRC_URI="http://linuxppc.jvc.nl/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/"
KEYWORDS="ppc -x86 -amd64 -alpha -arm -hppa -mips -sparc"
SLOT="0"
LICENSE="GPL-2"
DEPEND="sys-kernel/linux-headers
	X? ( virtual/x11 )"
RDEPEND="sys-apps/util-linux"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	mv pmud-0.10 ${P}
	cd ${S}
	patch -p1 < ${FILESDIR}/pmud-file-locations.patch
	use X || patch -p1 <${FILESDIR}/pmud-makefile-x-gentoo.diff
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	doman pmud.8 snooze.8 fblevel.8
	exeinto /sbin
	doexe pmud wakebay snooze fblevel 
	exeinto /etc/power
	doexe ${FILESDIR}/pwrctl{,-local} 
	exeinto /etc/init.d
	newexe ${FILESDIR}/pmud.start pmud
	insinto /etc
	doins ${FILESDIR}/power.conf
	use X && ( \
	doman batmon.8 xmouse.8
	exeinto /usr/bin 
	doexe Batmon 
	exeinto /usr/X11R6/bin
	doexe xmouse )
}
