# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.5_beta5.ebuild,v 1.11 2005/04/14 03:49:33 tgall Exp $

inherit flag-o-matic

MY_P=${P/_beta/beta}
MY_PV=${PV/_beta/beta}
S=${WORKDIR}/${MY_P}

DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"
SRC_URI="http://michael.toren.net/code/tcptraceroute/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ppc64"
IUSE=""

DEPEND="virtual/libpcap
	net-libs/libnet"

src_unpack() {
	unpack ${A}
	cd ${S}
	use ppc64 && epatch ${FILESDIR}/ppc64-1.5.patch
}

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
