# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-bootpd/netkit-bootpd-0.17-r1.ebuild,v 1.3 2000/09/15 20:09:12 drobbins Exp $

P=netkit-bootpd-0.17
A=netkit-bootparamd-0.17.tar.gz
S=${WORKDIR}/netkit-bootparamd-0.17
DESCRIPTION="Netkit - bootp"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

src_compile() {
    try ./configure                           
    try make
}

src_install() {                               
	into /usr
	dosbin rpc.bootparamd/bootparamd
	dosym  bootparamd /usr/sbin/rpc.bootparamd
	doman  rpc.bootparamd/bootparamd.8
	dosym  bootparamd.8.gz /usr/man/man8/rpc.bootparamd.8.gz
	doman  rpc.bootparamd/bootparams.5
	dodoc  README ChangeLog
	newdoc rpc.bootparamd/README README.bootparamd
}


