# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/hogwash/hogwash-0.1d.ebuild,v 1.1 2001/08/16 04:15:22 lamer Exp $

S=${WORKDIR}/devel
DESCRIPTION="layer2 packet scrubber. It lives right on top of the network driver and will drop or
sanitize packets based on signature. The authors installed it on an unpatched RH-6.2 box and entered
it into the capture the flag competition at defcon 9 and the box came back unscathed. I've included
the rules file too."
A="hogwash-0.1.d.tgz rules0727"
SRC_URI="http://prdownloads.sourceforge.net/hogwash/${PN}-0.1.d.tgz 
			http://hogwash.sourceforge.net/rules0727"
HOMEPAGE="http://hogwash.sourceforge.net"
DEPEND=">=net-libs/libpcap-0.6.1
		 >=net-libs/libnet-1.0.2a"

#RDEPEND=""
src_unpack() {
	unpack hogwash-0.1.d.tgz
}
src_compile() {

	try ./setup	

}

src_install () {
	
	dosbin hogwash
	insinto /etc/hogwash
	doins stock.rules ${DISTDIR}/rules0727
	dodoc COPYRIGHT README ${FILESDIR}/Documentation.txt
	dodir /var/log/snort
	
}

