# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/fakeidentd/fakeidentd-1.4.ebuild,v 1.1 2001/08/28 06:29:04 woodchip Exp $

# This identd is nearly perfect for a NAT box. It runs in one
# process (doesn't fork()) and isnt very susceptible to DOS attack.

DESCRIPTION="A static, secure identd. One source file only!"
HOMEPAGE="http://www.ajk.tele.fi/~too/sw"
S=${WORKDIR}/${P}
SRC_URI="http://www.ajk.tele.fi/~too/sw/releases/identd.c
         http://www.ajk.tele.fi/~too/sw/identd.readme"

DEPEND="virtual/glibc"

src_unpack() {
	mkdir ${P}
	cp ${DISTDIR}/identd.c ${DISTDIR}/identd.readme ${P}
}

src_compile() {
	cd ${S}
	gcc identd.c -o ${PN} ${CFLAGS}
}

src_install () {
	dosbin fakeidentd
	dodoc identd.readme
	# Changelog in source is more current. Its only ~13kB anyway.
	dodoc identd.c
}
