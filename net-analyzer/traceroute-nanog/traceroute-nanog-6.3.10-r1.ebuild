# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute-nanog/traceroute-nanog-6.3.10-r1.ebuild,v 1.2 2005/04/02 15:25:16 pylon Exp $

inherit eutils toolchain-funcs

MY_P="${PN}_${PV}"
DEB_PL="2"
DESCRIPTION="Traceroute with AS lookup, TOS support, MTU discovery and other features"
HOMEPAGE="http://packages.debian.org/traceroute-nanog"
SRC_URI="mirror://debian/pool/main/t/traceroute-nanog/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/t/traceroute-nanog/${MY_P}-${DEB_PL}.diff.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

S="${S}.orig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${MY_P}-${DEB_PL}.diff
}

src_compile() {
	$(tc-getCC) traceroute.c -o ${PN} ${CFLAGS} -lresolv -lm || die "Compile failed"
}

src_install() {
	dosbin traceroute-nanog || die "dosbin failed"
	dodoc 0_readme.txt faq.txt
	newman debian/traceroute.8 traceroute-nanog.8 || die "newman failed"
}
