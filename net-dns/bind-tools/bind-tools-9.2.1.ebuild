# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/net-misc/bind-tools/bind-tools-9.1.3-r1.ebuild,v 1.1 2001/12/09 23:47:08 jerrya Exp

MY_P=${P//-tools}
S=${WORKDIR}/${MY_P}
DESCRIPTION="bind tools: dig, nslookup, and host"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${MY_P}.tar.gz"
HOMEPAGE="http://www.isc.org/BIND/bind9.html"

KEYWORDS="x86 ppc sparc sparc64"
LICENSE="as-is"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${MY_P}.tar.gz

}
 
src_compile() {
	econf || die "configure failed"

	cd ${S}/lib/isc
	make || die "make failed in /lib/isc"

	cd ${S}/lib/dns
	make || die "make failed in /lib/dns"

	cd ${S}/bin/dig
	make || die "make failed in /bin/dig"
}
 
src_install() {
	cd ${S}/bin/dig
	dobin dig host nslookup
	doman dig.1 host.1

	doman ${FILESDIR}/nslookup.8

	cd ${S}
	dodoc  README CHANGES FAQ COPYRIGHT
}
