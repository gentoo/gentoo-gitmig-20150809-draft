# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute-nanog/traceroute-nanog-6.3.10.ebuild,v 1.2 2005/02/01 00:36:27 ka0ttic Exp $

inherit gcc eutils

DESCRIPTION="Traceroute with AS lookup, TOS support, MTU discovery and other features"
HOMEPAGE="http://packages.debian.org/traceroute-nanog"

MY_PREV=1

SRC_URI="mirror://debian/pool/main/t/traceroute-nanog/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/t/traceroute-nanog/${PN}_${PV}-${MY_PREV}.diff.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/libc"

S=${S}.orig

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${WORKDIR}/${PN}_${PV}-${MY_PREV}.diff
}

src_compile() {
	$(gcc-getCC) traceroute.c -o ${PN} ${CFLAGS} -lresolv -lm || die "Compile failed"
}

src_install() {
	dosbin traceroute-nanog
	dodoc 0_readme.txt faq.txt

	mv debian/traceroute.8 traceroute-nanog.8
	doman traceroute-nanog.8
}
