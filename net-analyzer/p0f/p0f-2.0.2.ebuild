# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/p0f/p0f-2.0.2.ebuild,v 1.7 2004/10/15 10:01:30 eldad Exp $

DESCRIPTION="p0f performs passive OS detection based on SYN packets."
# the p0f.tgz always resembles the latest version, trashing the digest md5sum then, discovered and fixed by gustavoz
SRC_URI="http://lcamtuf.coredump.cx/p0f/${P}.tgz"
HOMEPAGE="http://lcamtuf.coredump.cx/p0f.shtml"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"
IUSE=""

DEPEND="net-libs/libpcap"

src_compile () {
	cd ${WORKDIR}/p0f
	sed -i "s: /usr/sbin/: ../../image/usr/sbin/:g" ${WORKDIR}/p0f/mk/Linux
	sed -i "s: /etc/p0f: ../../image/etc/p0f:g" ${WORKDIR}/p0f/mk/Linux
	sed -i "s: /usr/man/man1/: ../../image/usr/man/man1/:g" ${WORKDIR}/p0f/mk/Linux

	sed -e 's;#include <net/bpf.h>;;' -i p0f.c

	make || die
}

src_install () {
	cd ${WORKDIR}/p0f
	dodir /usr/sbin; dodir /etc/p0f; dodir /usr/man/man1
	mkdir -p ../../image/usr/sbin ../../image/etc/p0f ../../image/usr/man/man1
	make install || die
}

