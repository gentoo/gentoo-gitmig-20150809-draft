# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/p0f/p0f-2.0.3.ebuild,v 1.10 2004/10/23 06:41:17 mr_bones_ Exp $

inherit eutils

DESCRIPTION="p0f performs passive OS detection based on SYN packets."
# the p0f.tgz always resembles the latest version, trashing the digest md5sum then, discovered and fixed by gustavoz
SRC_URI="http://lcamtuf.coredump.cx/p0f/${P}.tgz"
HOMEPAGE="http://lcamtuf.coredump.cx/p0f.shtml"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~amd64 sparc ppc-macos"
IUSE=""
S=${WORKDIR}/${PN}


DEPEND="net-libs/libpcap"

src_compile() {
	sed -e 's;#include <net/bpf.h>;;' -i p0f.c

	make || die
}

src_install () {
	dosbin p0f p0frep

	insinto /etc/p0f
	doins p0f.fp p0fa.fp p0fr.fp

	doman p0f.1

	dodoc README
}

