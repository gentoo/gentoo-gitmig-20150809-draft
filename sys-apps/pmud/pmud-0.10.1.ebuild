# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Id: pmud-0.10.1.ebuild,v 1.3 2002/07/14 19:20:19 aliz Exp $

S=${WORKDIR}/${P}

DESCRIPTION="PowerMac power management utilities"
SRC_URI="http://linuxppc.jvc.nl/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DEPEND="sys-kernel/linux-headers"
RDEPEND="sys-apps/util-linux"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	mv pmud-0.10 ${P}
	cd ${S}
	patch -p1 < ${FILESDIR}/pmud-file-locations.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	doman pmud.8 snooze.8 fblevel.8 batmon.8 xmouse.8
	exeinto /sbin
	doexe pmud wakebay snooze fblevel
	exeinto /usr/bin
	doexe Batmon
	exeinto /usr/X11R6/bin
	doexe xmouse
	exeinto /etc/power
	doexe ${FILESDIR}/pwrctl{,-local}

	exeinto /etc/init.d
	newexe ${FILESDIR}/pmud.start pmud
	insinto /etc
	doins ${FILESDIR}/power.conf
}
