# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reiserfsprogs/reiserfsprogs-3.1c.ebuild,v 1.2 2002/07/14 19:20:19 aliz Exp $

MYPV=3.x.1c-pre3
S=${WORKDIR}/reiserfsprogs-${MYPV}
DESCRIPTION="Reiserfs Utilities"
SRC_URI="ftp://ftp.namesys.com/pub/reiserfsprogs/pre/reiserfsprogs-${MYPV}.tar.gz"
HOMEPAGE="http://www.namesys.com"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	./configure --prefix=/ || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodir /usr/share
	cd ${D}
	mv man usr/share
	dosym /sbin/reiserfsck /sbin/fsck.reiserfs
	if [ "`use bootcd`" ]
	then
		rm -rf ${D}/usr
	fi
}

