# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gluelog/gluelog-1.0-r2.ebuild,v 1.5 2002/07/21 19:44:42 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Pipe and socket fittings for the system and kernel logs"
HOMEPAGE="http://www.linuxuser.co.za/projects.php3"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"
SRC_URI=""

DEPEND="virtual/glibc"

src_compile() {

	mkdir ${S}

	cd ${FILESDIR}
	gcc ${CFLAGS} gluelog.c -o ${S}/gluelog || die
	gcc ${CFLAGS} glueklog.c -o ${S}/glueklog || die
}

src_install() {

	dodir /usr/sbin
	dosbin ${S}/gluelog ${S}/glueklog
	exeopts -m0750 -g wheel
	dodir /var/log
	local x
	for x in syslog klog
	do
		exeinto /var/lib/supervise/services/${x}
		newexe ${FILESDIR}/${x}-run run
		install -d -m0750 -o daemon -g wheel ${D}/var/log/${x}.d
		exeinto /etc/rc.d/init.d
		doexe ${FILESDIR}/svc-${x}
	done

        dodoc ${FILESDIR}/README
}

