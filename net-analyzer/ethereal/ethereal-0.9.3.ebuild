# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>, Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.9.3.ebuild,v 1.3 2002/04/17 04:26:07 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A commercial-quality network protocol analyzer"
SRC_URI="http://www.ethereal.com/distribution/${P}.tar.gz"
HOMEPAGE="http://www.ethereal.com/"

RDEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	=dev-libs/glib-1.2*
	snmp? ( >=net-analyzer/ucd-snmp-4.1.2 )
	X? ( virtual/x11 >=x11-libs/gtk+-1.2.0 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

DEPEND="${RDEPEND}
	sys-devel/perl
	sys-devel/bison
	sys-devel/flex
	>=net-libs/libpcap-0.5.2"

src_compile() {

	local myconf
	use ssl || myconf="${myconf} --without-ssl"
	use snmp || myconf="${myconf} --disable-snmp"
	use X || myconf="${myconf} --disable-ethereal"

	./configure --prefix=/usr --host=${CHOST} ${myconf} \
	--with-plugindir=/usr/lib/ethereal/plugins/${PV} \
	--mandir=/usr/share/man --sysconfdir=/etc/ethereal \
	--enable-pcap --enable-zlib --enable-ipv6 || die

	make || die "compile problem"
}

src_install() {

	dodir /usr/lib/ethereal/plugins/${PV}

	make plugindir=${D}/usr/lib/ethereal/plugins/${PV} \
	prefix=${D}/usr sysconfdir=${D}/etc/ethereal \
	mandir=${D}/usr/share/man install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL.* NEWS README* TODO
}
