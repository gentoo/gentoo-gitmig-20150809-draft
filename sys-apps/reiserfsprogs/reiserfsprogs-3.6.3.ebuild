# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reiserfsprogs/reiserfsprogs-3.6.3.ebuild,v 1.2 2002/09/16 16:50:52 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Reiserfs Utilities"
SRC_URI="ftp://ftp.namesys.com/pub/reiserfsprogs/${P}.tar.gz"
HOMEPAGE="http://www.namesys.com"
KEYWORDS="x86 ppc sparc sparc64 alpha"
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

