# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/p0f/p0f-1.8.2.ebuild,v 1.15 2004/10/15 10:01:30 eldad Exp $

inherit eutils

DESCRIPTION="p0f performs passive OS detection based on SYN packets."
SRC_URI="http://www.stearns.org/p0f/p0f-1.8.2.tgz"
HOMEPAGE="http://www.stearns.org/p0f/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="net-libs/libpcap"

src_compile() {
	epatch ${FILESDIR}/${P}-makefile.patch
	sed -e 's;#include <net/bpf.h>;;' -i p0f.c

	cp ${FILESDIR}/${P}.rc p0f.rc
	make || die
}

src_install () {
	dodir /usr/bin /usr/sbin /usr/share/doc /usr/share/man/man1 /etc/init.d
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	einfo "You can start the p0f monitoring program on boot time by running"
	einfo "rc-update add p0f default"
}
