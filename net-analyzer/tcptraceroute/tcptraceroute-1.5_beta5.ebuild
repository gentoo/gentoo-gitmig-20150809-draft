# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.5_beta5.ebuild,v 1.4 2004/07/31 19:12:45 malc Exp $

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

DEPEND="net-libs/libpcap
	net-libs/libnet"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dosbin tcptraceroute
	fperms 4710 /usr/sbin/tcptraceroute
	fowners root:wheel /usr/sbin/tcptraceroute
	doman tcptraceroute.1
	dodoc examples.txt COPYING README changelog
	dohtml -r ./
}
