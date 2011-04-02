# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hping/hping-2.0.0_rc3-r1.ebuild,v 1.12 2011/04/02 12:54:02 ssuominen Exp $

inherit eutils

MY_P="${PN}${PV//_/-}"
DESCRIPTION="A ping-like TCP/IP packet assembler/analyzer"
HOMEPAGE="http://www.hping.org"
SRC_URI="http://www.hping.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE="debug"

DEPEND="net-libs/libpcap"

S="${WORKDIR}/${MY_P//\.[0-9]}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/bytesex.h.patch
	epatch ${FILESDIR}/hping-bridge.patch
}

src_compile() {
	./configure || die

	if use debug
	then
		make CCOPT="${CFLAGS}" || die
	else
		make CCOPT="${CFLAGS}" DEBUG="" || die
	fi
}

src_install () {
	dodir /usr/sbin
	dosbin hping2
	dosym /usr/sbin/hping2 /usr/sbin/hping

	doman docs/hping2.8
	dodoc INSTALL KNOWN-BUGS NEWS README TODO AUTHORS BUGS CHANGES COPYING docs/AS-BACKDOOR docs/HPING2-IS-OPEN docs/MORE-FUN-WITH-IPID docs/*.txt
}
