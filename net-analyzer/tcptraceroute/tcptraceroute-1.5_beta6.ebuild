# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.5_beta6.ebuild,v 1.1 2005/03/23 01:05:23 vanquirius Exp $

inherit flag-o-matic

MY_P=${P/_beta/beta}
MY_PV=${PV/_beta/beta}
S=${WORKDIR}/${MY_P}

DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"
SRC_URI="http://michael.toren.net/code/tcptraceroute/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND="virtual/libpcap
	net-libs/libnet"

src_compile() {
	append-ldflags -Wl,-z,now

	econf || die
	emake || die
}

src_install() {
	dosbin tcptraceroute
	fperms 4710 /usr/sbin/tcptraceroute
	fowners root:wheel /usr/sbin/tcptraceroute
	doman tcptraceroute.1
	dodoc examples.txt COPYING README ChangeLog
	dohtml -r ./
}
