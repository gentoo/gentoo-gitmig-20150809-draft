# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-1.3.20_p0-r1.ebuild,v 1.2 2001/08/29 04:37:45 drobbins Exp $

MYV=1.3.20-pl0
S=${WORKDIR}/${PN}-${MYV}
DESCRIPTION="A dhcp client only"
SRC_URI="ftp://ftp.phystech.cm/pub/${PN}-${MYV}.tar.gz"
HOMEPAGE="http://"
DEPEND=""

src_compile() {
	./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --sbindir=/sbin --host=${CHOST} || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	if [ -z "`use bootcd`" ] && [ =z "`use build`" ]
	then
		dodoc AUTHORS COPYING ChangeLog NEWS README 
	else
		rm -rf ${D}/usr/share
	fi
	if [ "`use pcmcia`" ] || [ "`use pcmcia-cs`" ]
	then
		insinto /etc/pcmcia
		doins pcmcia/network*
	fi
}
