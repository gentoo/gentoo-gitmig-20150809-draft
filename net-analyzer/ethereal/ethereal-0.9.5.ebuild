# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.9.3-r1.ebuild,v 1.2 2002/05/23 06:50:15 seemant Exp

S=${WORKDIR}/${P}
DESCRIPTION="A commercial-quality network protocol analyzer"
SRC_URI="http://www.ethereal.com/distribution/${P}.tar.gz"
HOMEPAGE="http://www.ethereal.com/"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	=dev-libs/glib-1.2*
	snmp? ( >=net-analyzer/ucd-snmp-4.1.2 )
	X? ( virtual/x11 =x11-libs/gtk+-1.2* )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

DEPEND="${RDEPEND}
	sys-devel/perl
	sys-devel/bison
	sys-devel/flex
	>=net-libs/libpcap-0.5.2"

src_compile() {
	local myconf
	use X || myconf="${myconf} --disable-ethereal"
	use ssl || myconf="${myconf} --without-ssl"
	use snmp || myconf="${myconf} --disable-snmp"

	./configure \
		--prefix=/usr \
		--enable-pcap \
		--enable-zlib \
		--enable-ipv6 \
		--includedir="" \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/ethereal \
		--with-plugindir=/usr/lib/ethereal/plugins/${PV} \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	make || die "compile problem"
}

src_install() {
	dodir /usr/lib/ethereal/plugins/${PV}

	make install \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		sysconfdir=${D}/etc/ethereal \
		plugindir=${D}/usr/lib/ethereal/plugins/${PV} || die

	dodoc AUTHORS COPYING ChangeLog INSTALL.* NEWS README* TODO
}
