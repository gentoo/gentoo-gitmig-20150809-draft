# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Michael Nazaroff <naz@themoonsofjupiter.net>
# /home/cvsroot/gentoo-x86/net-misc/bind-tools/bind-tools-9.1.3.ebuild,v 1

A=bind-9.1.3.tar.gz
S=${WORKDIR}/bind-9.1.3
DESCRIPTION="bind tools: dig, nslookup, and host"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${A}"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

src_unpack() {
        unpack ${A}

}
 
src_compile() {
    
	cd ${S}    
	./configure --host=${CHOST} || die
        cd ${S}/lib/isc
		make || die
		cd ${S}/lib/dns
		make || die
		cd ${S}/bin/dig
		make || die
}
 
src_install() {
	insinto /usr
		dobin  ${S}/bin/dig/dig
		dobin  ${S}/bin/dig/nslookup
		dobin  ${S}/bin/dig/host
        	doman  ${S}/doc/man/bin/dig.1
		doman  ${S}/doc/man/bin/host.1
        	dodoc  README CHANGES FAQ COPYRIGHT
        
}
