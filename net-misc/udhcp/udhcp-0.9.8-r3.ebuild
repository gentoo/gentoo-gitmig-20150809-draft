# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udhcp/udhcp-0.9.8-r3.ebuild,v 1.13 2005/08/24 00:05:22 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="udhcp Server/Client Package"
HOMEPAGE="http://udhcp.busybox.net/"
SRC_URI="http://udhcp.busybox.net/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ~ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"
PROVIDE="virtual/dhcpc"

pkg_setup() {
	enewgroup dhcp
	enewuser dhcp -1 -1 /var/lib/dhcp dhcp
}

src_unpack() {

	unpack ${A}
	cd ${S}
	#fixes #62714, thanks GurliGebis
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch "${FILESDIR}"/udhcp-gcc-3.4.patch
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

	dodoc AUTHORS ChangeLog README* TODO

	insinto /usr/share/udhcpc
	doins samples/*
}
