# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/pop3vscan/pop3vscan-0.4.ebuild,v 1.1 2002/07/10 21:18:34 bass Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A transparent POP3-Proxy with virus-scanning capabilities."
SRC_URI="mirror://sourceforge/pop3vscan/${P}.tar.gz"
HOMEPAGE="pop3vscan.sf.net"
LICENSE="GPL-2"
DEPEND="net-mail/ripmime"
RDEPEND="${DEPEND}"
SLOT="0"

src_compile() {
	make || die
}

src_install () {
	dodir /usr/sbin
	dosbin pop3vscan
	dodir /etc
	insinto /etc
	doins pop3vscan.conf pop3vscan.mail 

	insinto /etc/init.d
	doins ${FILESDIR}/pop3vscan
	fperms 755 /etc/init.d/pop3vscan

	dodoc README
}

pkg_postinstall () {
	einfo "You need configure /etc/pop3vscan and /etc/pop3vscan.mail"
	einfo "For start pop3vscan you can use /etc/init.d/pop3vscan start"
}
