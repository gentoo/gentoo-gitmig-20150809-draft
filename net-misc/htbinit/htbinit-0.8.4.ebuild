# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/htbinit/htbinit-0.8.4.ebuild,v 1.1 2003/08/17 18:34:53 bass Exp $

DESCRIPTION="Sets up Hierachical Token Bucket based traffic control (QoS) with iproute2"
HOMEPAGE="http://www.sourceforge.net/projects/htbinit"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/htbinit/htb.init-v${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="sys-apps/iproute"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp ${DISTDIR}/htb.init-v${PV} ${S}
}

src_compile() {
	mv htb.init-v${PV} htb.init-v${PV}.orig
	sed <htb.init-v${PV}.orig >htb.init-v${PV} \
		-e 's|HTB_PATH=${HTB_PATH:-/etc/sysconfig/htb}|HTB_PATH=/etc/htbinit|' \
		-e 's|HTB_CACHE=${HTB_CACHE:-/var/cache/htb.init}|HTB_CACHE=/var/cache/htbinit|' 
}

src_install() {
	mv htb.init-v${PV} htbinit

	exeinto /usr/sbin
	doexe htbinit

	exeinto /usr/sbin
	doexe ${FILESDIR}/htb.sysconfig

	exeinto /etc/init.d
	newexe ${FILESDIR}/rc_htbinit htbinit

	dodoc htbinit ${FILESDIR}/htb.sysconfig
}

pkg_postinst() {
	einfo 'Run "rc-update add htbinit default" to run htbinit at startup.'
	einfo 'Edit "/usr/sbin/htb.sysconfig" to make a custom configuration.'
	einfo 'Please, read carefully the htbinit and htb.sysconfig documentation.'
}
