# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udhcp/udhcp-0.9.8.ebuild,v 1.2 2003/02/13 15:09:23 vapier Exp $

DESCRIPTION="udhcp Server/Client Package"
HOMEPAGE="http://udhcp.busybox.net/"
SRC_URI="http://udhcp.busybox.net/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND=""

src_compile() {
	emake SYSLOG=1 || die
}

src_install() {
	dodir /usr/sbin
	dodir /usr/bin
	dodir /sbin
	dodir /etc
	install -m644 samples/udhcpd.conf ${D}/etc
	make prefix=${D}/usr SBINDIR=${D}/sbin install || die
}
