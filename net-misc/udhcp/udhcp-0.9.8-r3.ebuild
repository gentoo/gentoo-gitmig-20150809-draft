# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udhcp/udhcp-0.9.8-r3.ebuild,v 1.1 2004/03/08 23:51:40 seemant Exp $

DESCRIPTION="udhcp Server/Client Package"
HOMEPAGE="http://udhcp.busybox.net/"
SRC_URI="http://udhcp.busybox.net/source/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 amd64"

DEPEND="virtual/glibc"

PROIVDE="virtual/dhcpc"

src_compile() {
	emake SYSLOG=1 || die
}

src_install() {
	dodir /usr/sbin
	dodir /usr/bin
	dodir /sbin

	insinto /etc
	doins samples/udhcpd.conf

	make prefix=${D}/usr SBINDIR=${D}/sbin install || die

	dodoc AUTHORS COPYING ChangeLog README* TODO

	insinto /usr/share/udhcpc
	doins samples/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/udhcp.init udhcp
}
