# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpcast/udpcast-20040222.ebuild,v 1.4 2004/07/31 21:28:08 malc Exp $

IUSE=""
DESCRIPTION="Multicast file transfer tool"
HOMEPAGE="http://udpcast.linux.lu/"
SRC_URI="http://udpcast.linux.lu/current/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/libc
	dev-lang/perl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	# sed the manpages to only depend on one because the rule that
	# builds them makes them both ... however, if we build in parallel,
	# the command may be run twice thus clobbering each other
	sed -i \
		-e 's:/sbin:/bin:' \
		-e "/^CFLAGS =/s:$: ${CFLAGS}:" \
		-e 's:udp-receiver\.1 udp-sender\.1:udp-receiver.1:' \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc Changelog.txt
}
