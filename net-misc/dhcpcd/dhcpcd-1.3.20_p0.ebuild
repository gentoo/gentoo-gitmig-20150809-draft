# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header:

A=${PN}-1.3.20-pl0.tar.gz
S=${WORKDIR}/${PN}-1.3.20-pl0
DESCRIPTION="A dhcp client only"
SRC_URI="ftp://ftp.phystech.cm/pub/${A}"
HOMEPAGE="http://"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

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

