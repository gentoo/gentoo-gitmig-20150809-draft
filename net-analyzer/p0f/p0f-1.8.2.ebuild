# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/p0f/p0f-1.8.2.ebuild,v 1.12 2004/04/27 21:15:12 agriffis Exp $

DESCRIPTION="p0f performs passive OS detection based on SYN packets."
SRC_URI="http://www.stearns.org/p0f/p0f-1.8.2.tgz"
HOMEPAGE="http://www.stearns.org/p0f/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "

DEPEND="net-libs/libpcap"

src_compile() {
	patch < ${FILESDIR}/${P}-makefile.patch
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
