# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-1.2.1.ebuild,v 1.5 2002/07/21 19:54:28 gerk Exp $

DESCRIPTION="Administratinve interface to grsecurity"
SRC_URI="http://www.grsecurity.net/gradm-1.2.1.tar.gz
	http://pageexec.virtualave.net/chpax.c"
HOMEPAGE="http://www.grsecurity.net"
KEYWORDS="x86 ppc"
SLOT="0"
#DEPEND=""
LICENSE="GPL-2"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	cp ${DISTDIR}/chpax.c .
}

src_compile() {
	./configure || die
	emake || die
	emake chpax || die
}

src_install() {
	dodir /sbin /etc/grsec /etc/init.d /etc/conf.d /usr/share/man/man8

	cp gradm ${D}/sbin
	gzip -9 gradm.8
	cp gradm.8.gz ${D}/usr/share/man/man8
	cp chpax ${D}/sbin
	chmod 0700 ${D}/sbin/*
	cp ${FILESDIR}/grsecurity.rc ${D}/etc/init.d/grsecurity
	chmod 755 ${D}/etc/init.d/*
	cp ${FILESDIR}/grsecurity ${D}/etc/conf.d/grsecurity
	chmod 644 ${D}/etc/conf.d/*

	dodoc ChangeLog* INSTALL COPYING
}
