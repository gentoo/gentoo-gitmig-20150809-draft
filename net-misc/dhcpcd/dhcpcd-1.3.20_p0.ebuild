# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-1.3.20_p0.ebuild,v 1.1 2001/05/09 01:50:24 achim Exp $

A=${PN}-1.3.20-pl0.tar.gz
S=${WORKDIR}/${PN}-1.3.20-pl0
DESCRIPTION="A dhcp client only"
SRC_URI="ftp://ftp.phystech.cm/pub/${A}"
HOMEPAGE="http://"

DEPEND=""

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --sbindir=/sbin --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README 
    if [ "`use pcmcia`" ] || [ "`use pcmcia-cs`" ] ; then
	insinto /etc/pcmcia
	doins pcmcia/network*
    fi

}

