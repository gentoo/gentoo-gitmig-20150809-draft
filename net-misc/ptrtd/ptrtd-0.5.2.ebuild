# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ptrtd/ptrtd-0.5.2.ebuild,v 1.5 2004/09/03 15:12:19 dholm Exp $

DESCRIPTION="Portable Transport Relay Translator Daemon for IPv6"
HOMEPAGE="http://v6web.litech.org/ptrtd/"
SRC_URI="http://v6web.litech.org/ptrtd/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/iproute2"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv -f Makefile.in ${T}
	sed -e "s:-Wall -g:-Wall ${CFLAGS}:" \
		${T}/Makefile.in > Makefile.in
}

src_install() {
	einstall || die

	dodir /etc/init.d
	dodir /etc/conf.d

	exeinto /etc/init.d/
	newexe ${FILESDIR}/ptrtd.initd ptrtd

	insinto /etc/conf.d/
	newins ${FILESDIR}/ptrtd.confd ptrtd

	dodoc README
}

pkg_postinst() {
	einfo "ptrtd requires access to the 'tun' and 'tap' interfaces to function"
	einfo "Make sure you have compiled support for it under"
	einfo "Network Device Support -> Universal TUN/TAP device driver support"
}
