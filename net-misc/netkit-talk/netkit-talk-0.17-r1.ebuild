# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-talk/netkit-talk-0.17-r1.ebuild,v 1.2 2000/08/16 04:38:18 drobbins Exp $

P=netkit-talk-0.17
A=netkit-ntalk-0.17.tar.gz
S=${WORKDIR}/netkit-ntalk-0.17
DESCRIPTION="Netkit - talkd"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

src_compile() {
    ./configure                           
    make
}

src_install() {                               
	into /usr
	dobin  talk/talk
	doman  talk/talk.1
	dosbin talkd/talkd
	dosym  talkd /usr/sbin/in.talkd
	doman  talkd/talkd.8
	dosym  talkd.8.gz /usr/man/man8/in.talkd.8.gz
	dodoc  README ChangeLog BUGS
}


