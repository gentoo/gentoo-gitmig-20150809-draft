# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/taylor-uucp/taylor-uucp-1.06.2.ebuild,v 1.4 2002/08/14 12:08:08 murphy Exp $

A="uucp-${PV}.tar.gz"
S=${WORKDIR}/uucp-1.06.1	# This should be a .2 bug the package is messed
DESCRIPTION="Taylor UUCP"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/uucp/${A}"
HOMEPAGE="http://www.airs.com/ian/uucp.html"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_compile ()
{
	./configure --prefix=/usr --host=${CHOST}
	make sbindir=/usr/sbin bindir=/usr/bin man1dir=/usr/share/man/man1 man8dir=/usr/share/man/man8 newconfigdir=/etc/uucp infodir=/usr/share/info || die
}

src_install ()
{
	mkdir -p ${D}/usr/share/man/man1
	mkdir -p ${D}/usr/share/man/man8
	mkdir -p ${D}/usr/share/info
	mkdir -p ${D}/etc/uucp
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/sbin
	make prefix=${D}/usr sbindir=${D}/usr/sbin bindir=${D}/usr/bin man1dir=${D}/usr/share/man/man1 man8dir=${D}/usr/share/man/man8 newconfigdir=${D}/etc/uucp infodir=${D}/usr/share/info install || die
	make prefix=${D}/usr sbindir=${D}/usr/sbin bindir=${D}/usr/bin man1dir=${D}/usr/share/man/man1 man8dir=${D}/usr/share/man/man8 newconfigdir=${D}/etc/uucp infodir=${D}/usr/share/info install-info || die
	dodoc COPYING ChangeLog MANIFEST NEWS README TODO
}
