# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/p0f/p0f-2.0.3.ebuild,v 1.6 2004/07/26 04:26:07 j4rg0n Exp $

inherit eutils

DESCRIPTION="p0f performs passive OS detection based on SYN packets."
# the p0f.tgz always resembles the latest version, trashing the digest md5sum then, discovered and fixed by gustavoz
SRC_URI="http://lcamtuf.coredump.cx/p0f/${P}.tgz"
HOMEPAGE="http://lcamtuf.coredump.cx/p0f.shtml"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~amd64 ~sparc macos"
IUSE=""
S=${WORKDIR}/${PN}


DEPEND="net-libs/libpcap"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-libpcap-include.patch
}

src_compile() {
	make || die
}

src_install () {
	dosbin p0f p0frep

	insinto /etc/p0f
	doins p0f.fp p0fa.fp p0fr.fp

	doman p0f.1

	dodoc README
}

