# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

S=${WORKDIR}/${P}
IUSE="pam snmp ipv6"

DESCRIPTION="Multithreaded TCP/IP Routing Software that supports BGP-4, RIPv1, RIPv2 and OSPFv2"
SRC_URI="ftp://ftp.zebra.org/pub/zebra/${P}.tar.gz"
HOMEPAGE="http://www.zebra.org"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	pam? ( >=pam-0.75-r11 )"

src_compile() {
	local myconf=""
	use pam || myconf="$myconf --disable-pam"
	use snmp || myconf="$myconf --disable-snmp"
	use ipv6 || myconf="$myconf --disable-ipv6"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/zebra \
		--localstatedir=/var \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	emake || die "Parallel Make Failed"	
}

src_install() {                               
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/zebra \
		localstatedir=${D}/var \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die "Installation Failed"

	cp */*.conf.sample ${D}/etc/zebra

	exeinto /etc/init.d ; newexe ${FILESDIR}/zebra.initd zebra
	insinto /etc/conf.d ; newins ${FILESDIR}/zebra.confd zebra
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README REPORTING-BUGS SERVICES TODO
}
