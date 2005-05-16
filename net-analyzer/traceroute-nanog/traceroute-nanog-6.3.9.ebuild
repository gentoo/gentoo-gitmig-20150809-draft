# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute-nanog/traceroute-nanog-6.3.9.ebuild,v 1.5 2005/05/16 01:14:38 vanquirius Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Traceroute with AS lookup, TOS support, MTU discovery and other features"
HOMEPAGE="http://packages.debian.org/traceroute-nanog"
SRC_URI="mirror://debian/pool/main/t/traceroute-nanog/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/t/traceroute-nanog/${PN}_${PV}-3.diff.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${WORKDIR}/${PN}_${PV}-3.diff
}

src_compile() {
	$(tc-getCC) traceroute.c -o ${PN} ${CFLAGS} -lresolv -lm || die "Compile failed"
}

src_install() {
	dosbin traceroute-nanog
	dodoc 0_readme.txt faq.txt

	mv debian/traceroute.8 traceroute-nanog.8
	doman traceroute-nanog.8
}
