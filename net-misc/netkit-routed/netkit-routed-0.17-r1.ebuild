# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-routed/netkit-routed-0.17-r1.ebuild,v 1.1 2000/08/09 22:58:28 achim Exp $

P=netkit-routed-0.17
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Netkit - routed"
CATEGORY=net-misc
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

src_compile() {  
    ./configure                         
    make
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


