# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-fingerd/netkit-fingerd-0.17-r1.ebuild,v 1.3 2000/09/15 20:09:12 drobbins Exp $

P=netkit-fingerd-0.17
A=bsd-finger-0.17.tar.gz
S=${WORKDIR}/bsd-finger-0.17
DESCRIPTION="Netkit - fingerd"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

src_compile() {     
    cd ${S}                      
    try ./configure
    try make
}

src_install() {                               
	into /usr
	dobin  finger/finger
	dosbin fingerd/fingerd
	dosym  fingerd /usr/sbin/in.fingerd
	doman  finger/finger.1
	doman  fingerd/fingerd.8
	dosym  fingerd.8.gz /usr/man/man8/in.fingerd.8.gz
	dodoc  README ChangeLog BUGS
}



