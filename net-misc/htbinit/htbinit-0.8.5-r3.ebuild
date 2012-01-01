# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/htbinit/htbinit-0.8.5-r3.ebuild,v 1.1 2012/01/01 00:56:46 idl0r Exp $

DESCRIPTION="Sets up Hierachical Token Bucket based traffic control (QoS) with iproute2"
HOMEPAGE="http://www.sourceforge.net/projects/htbinit"
SRC_URI="mirror://sourceforge/htbinit/htb.init-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha ~amd64"
IUSE=""

DEPEND="sys-apps/iproute2"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/htb.init-v${PV} "${S}"
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
	doexe "${FILESDIR}"/htb.sysconfig

	newinitd "${FILESDIR}"/rc_htbinit htbinit

	dodoc htbinit "${FILESDIR}"/htb.sysconfig

	dodir /etc/htbinit
}

pkg_postinst() {
	einfo 'Run "rc-update add htbinit default" to run htbinit at startup.'
	einfo 'Edit "/usr/sbin/htb.sysconfig" to make a custom configuration.'
	einfo 'Please, read carefully the htbinit and htb.sysconfig documentation.'
}
