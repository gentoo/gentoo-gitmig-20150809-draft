# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-routed/netkit-routed-0.17-r1.ebuild,v 1.8 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Netkit - routed"
SRC_URI="http://ftp.debian.org/debian/pool/main/n/netkit-routed/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/net/routed.html"
KEYWORDS="x86 sparc sparc64"
LICENSE="bsd"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {  
	./configure	|| die
	make || die
}

src_install() {							   
	into /usr
	dosbin ripquery/ripquery
	doman  ripquery/ripquery.8
	dosbin routed/routed
	dosym routed /usr/sbin/in.routed
	doman  routed/routed.8
	dosym routed.8.gz /usr/man/man8/in.routed.8.gz
	dodoc  README ChangeLog
	newdoc routed/README README.routed
}
