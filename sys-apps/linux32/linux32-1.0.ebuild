# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/linux32/linux32-1.0.ebuild,v 1.1 2003/07/13 22:55:22 drobbins Exp $

DESCRIPTION="A utility that allows AMD64 code to run in an environment so that the uname() call returns non-AMD64-specific info"
HOMEPAGE="ftp://ftp.x86-64.org/pub/linux-x86_64/tools/linux32/"
SRC_URI="mirror://${P}.tar.gz"
SLOT="0"
KEYWORDS="-* amd64"
LICENSE="GPL-2"

src_compile() {
	cd ${S}
	gcc ${CFLAGS} linux32.c -o linux32
}

src_install() {
	into /
	dobin ${S}/linux32
	ln -s linux32 ${D}/bin/linux64
	doman ${S}/linux32.1
	ln -s linux32.1.gz ${D}/usr/share/man/man1/linux64.1.gz
	dodoc ${S}/README
}
