# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gluelog/gluelog-1.0-r2.ebuild,v 1.16 2009/09/23 20:23:53 patrick Exp $

DESCRIPTION="Pipe and socket fittings for the system and kernel logs"
HOMEPAGE="http://www.linuxuser.co.za/projects.php3"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_unpack() {
	cp ${FILESDIR}/{gluelog,glueklog}.c . || die
}

src_compile() {
	emake gluelog glueklog || die
}

src_install() {
	dosbin gluelog glueklog || die
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
