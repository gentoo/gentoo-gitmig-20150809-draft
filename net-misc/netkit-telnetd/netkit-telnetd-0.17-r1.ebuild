# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-telnetd/netkit-telnetd-0.17-r1.ebuild,v 1.5 2001/05/28 05:24:13 achim Exp $

P=netkit-telnetd-0.17
A=netkit-telnet-0.17.tar.gz
S=${WORKDIR}/netkit-telnet-0.17
DESCRIPTION="Standard Linux telnet client"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {                           
    try ./configure --prefix=/usr
    cp MCONFIG MCONFIG.orig
    sed -e "s/-pipe -O2/${CFLAGS}/" -e "s:-Wpointer-arith::" MCONFIG.orig > MCONFIG
    try make
    cd telnetlogin
    try make
}

src_install() {
    into /usr
    dobin telnet/telnet
    dosbin telnetd/telnetd
    dosym telnetd /usr/sbin/in.telnetd
    dosbin telnetlogin/telnetlogin
    doman telnet/telnet.1
    doman telnetd/*.8
    dosym telentd.8.gz /usr/share/man/man8/in.telnetd.8.gz
    doman telnetlogin/telnetlogin.8
    dodoc BUGS ChangeLog README
    newdoc telnet/README README.telnet
    newdoc telnet/TODO TODO.telnet
  
}


