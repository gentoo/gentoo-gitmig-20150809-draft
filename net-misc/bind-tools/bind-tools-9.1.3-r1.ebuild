# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/bind-tools/bind-tools-9.1.3-r1.ebuild,v 1.1 2001/12/09 23:47:08 jerrya Exp $

S=${WORKDIR}/bind-9.1.3
DESCRIPTION="bind tools: dig, nslookup, and host"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${P//-tools}.tar.gz"
HOMEPAGE="http://www.isc.org/BIND/bind9.html"

DEPEND="virtual/glibc"


src_unpack() {
	unpack ${P//-tools}.tar.gz

}
 
src_compile() {
	./configure --host=${CHOST} || die

	cd ${S}/lib/isc
	make || die

	cd ${S}/lib/dns
	make || die

	cd ${S}/bin/dig
	make || die
}
 
src_install() {
	cd ${S}/bin/dig
	dobin dig host nslookup

	cd ${S}/doc/man/bin
	doman dig.1 host.1

	doman ${FILESDIR}/nslookup.8

	cd ${S}
	dodoc  README CHANGES FAQ COPYRIGHT
}
