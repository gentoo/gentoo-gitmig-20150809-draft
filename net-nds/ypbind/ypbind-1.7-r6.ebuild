# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypbind/ypbind-1.7-r6.ebuild,v 1.1 2001/10/06 07:00:03 woodchip Exp $

A=ypbind-mt-${PV}.tar.gz
S=${WORKDIR}/ypbind-mt-${PV}
DESCRIPTION="Multithreaded NIS bind service"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/"${A}
HOMEPAGE="http://www.suse.de/~kukuk/nis/ypbind-mt/index.html"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc
        net-nds/yp-tools
        net-nds/portmap"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man
	assert "bad configure"
	make || die
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man install || die
	dodoc AUTHORS ChangeLog COPYING README THANKS TODO

	insinto /etc ; doins etc/yp.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/ypbind.rc6 ypbind
}
