# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-routed/netkit-routed-0.17-r1.ebuild,v 1.3 2000/09/15 20:09:12 drobbins Exp $

P=netkit-routed-0.17
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Netkit - routed"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

src_compile() {  
    try ./configure                         
    try make
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


