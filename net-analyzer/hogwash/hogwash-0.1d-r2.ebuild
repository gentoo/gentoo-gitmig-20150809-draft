# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hogwash/hogwash-0.1d-r2.ebuild,v 1.5 2002/08/14 12:12:05 murphy Exp $

S=${WORKDIR}/devel
DESCRIPTION="An invisible, layer2 network packet scrubber based on snort"
HOMEPAGE="http://hogwash.sourceforge.net"
SRC_URI="mirror://sourceforge/hogwash/hogwash-0.1.d.tgz
	http://hogwash.sourceforge.net/rules.2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=net-libs/libpcap-0.6.1
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
