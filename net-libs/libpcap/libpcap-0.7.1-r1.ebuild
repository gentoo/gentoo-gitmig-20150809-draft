# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.7.1-r1.ebuild,v 1.1 2002/08/31 15:25:13 cselkirk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="pcap-Library"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz
	http://www.shaftnet.org/%7Epizza/software/libpcap-0.7.1-prism.diff"
HOMEPAGE="http://www.tcpdump.org/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc sparc64"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	patch -p0 < ${DISTDIR}/libpcap-0.7.1-prism.diff || die
	
}

src_compile() {

	local myconf
	use ipv6 && myconf="--enable-ipv6"

	econf ${myconf} || die "bad configure"

	emake || die "compile problem"

	# no provision for this in the Makefile, so...
	gcc -Wl,-soname,libpcap.so.0 -shared -fpic -o libpcap.so.0.6 *.o
	assert "couldn't make a shared lib"
}

src_install() {

	einstall || die

	insopts -m 755
	insinto /usr/lib ; doins libpcap.so.0.6
	dosym /usr/lib/libpcap.so.0.6 /usr/lib/libpcap.so.0
	dosym /usr/lib/libpcap.so.0.6 /usr/lib/libpcap.so

	dodoc CREDITS CHANGES FILES README* VERSION LICENSE
}
