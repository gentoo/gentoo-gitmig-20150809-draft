# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.5_beta7-r1.ebuild,v 1.7 2011/08/11 02:55:28 zmedico Exp $

inherit flag-o-matic

MY_P=${P/_beta/beta}
MY_PV=${PV/_beta/beta}
S=${WORKDIR}/${MY_P}

DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"
SRC_URI="http://michael.toren.net/code/tcptraceroute/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd ~x86-linux"
IUSE=""

DEPEND="net-libs/libpcap
	net-libs/libnet"

src_install() {
	dosbin tcptraceroute
	fowners root:wheel /usr/sbin/tcptraceroute
	fperms 4710 /usr/sbin/tcptraceroute
	doman tcptraceroute.1
	dodoc examples.txt README ChangeLog
	dohtml tcptraceroute.1.html
}
