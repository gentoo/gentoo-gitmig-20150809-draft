# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ptrtd/ptrtd-0.5.2.ebuild,v 1.1 2003/05/31 19:34:44 latexer Exp $

DESCRIPTION="Portable Transport Relay Translator Daemon for IPv6"

HOMEPAGE="http://v6web.litech.org/ptrtd"

SRC_URI="http://v6web.litech.org/ptrtd/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
DEPEND=""
RDEPEND="sys-apps/iproute"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv -f Makefile.in ${T}
	sed -e "s:-Wall -g:-Wall ${CFLAGS}:" \
		${T}/Makefile.in > Makefile.in
}

src_compile() {
	econf || die
	emake || die
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
