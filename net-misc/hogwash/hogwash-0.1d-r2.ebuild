# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/hogwash/hogwash-0.1d-r2.ebuild,v 1.3 2002/05/27 17:27:39 drobbins Exp $

DESCRIPTION="An invisible, layer2 network packet scrubber based on snort"
HOMEPAGE="http://hogwash.sourceforge.net"

S=${WORKDIR}/devel
SRC_URI="mirror://sourceforge/hogwash/hogwash-0.1.d.tgz
	http://hogwash.sourceforge.net/rules.2"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.6.1
	>=net-libs/libnet-1.0.2a"

src_unpack() {

	unpack hogwash-0.1.d.tgz
}

src_compile() {

	./setup || die
}

src_install () {
	
	dosbin hogwash
	dodoc COPYRIGHT README ${FILESDIR}/Documentation.txt
	dodir /var/log/snort
	dodir /var/log/hogwash

	insinto /etc/hogwash ; doins stock.rules ${DISTDIR}/rules.2
	exeinto /etc/init.d ; newexe ${FILESDIR}/hogwash.rc6 hogwash
}
