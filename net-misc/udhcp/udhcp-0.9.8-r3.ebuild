# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udhcp/udhcp-0.9.8-r3.ebuild,v 1.10 2004/09/04 00:33:24 morfic Exp $

inherit eutils gcc

DESCRIPTION="udhcp Server/Client Package"
HOMEPAGE="http://udhcp.busybox.net/"
SRC_URI="http://udhcp.busybox.net/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips ~alpha arm hppa amd64 ~ia64"
IUSE=""

DEPEND="virtual/libc"
PROVIDE="virtual/dhcpc"

pkg_setup() {
	enewgroup dhcp
	enewuser dhcp -1 /bin/false /var/lib/dhcp dhcp
}

src_unpack() {

	unpack ${A}
	cd ${S}
	#fixes #62714, thanks GurliGebis
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch ${FILESDIR}/udhcp-gcc-3.4.patch
	fi
}

src_compile() {
	emake CROSS_COMPILE=${CHOST}- STRIP=true SYSLOG=1 || die
}

src_install() {
	dodir /usr/sbin /usr/bin /sbin

	insinto /etc
	doins samples/udhcpd.conf

	make \
		prefix=${D}/usr \
		SBINDIR=${D}/sbin \
		CROSS_COMPILE=${CHOST}- \
		STRIP=true \
		install \
		|| die

	dodoc AUTHORS COPYING ChangeLog README* TODO

	insinto /usr/share/udhcpc
	doins samples/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/udhcp.init udhcp
}
