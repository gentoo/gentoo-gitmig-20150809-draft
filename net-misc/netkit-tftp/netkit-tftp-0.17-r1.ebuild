# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Travis Tilley <lordviram@nesit.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-tftp/netkit-tftp-0.17-r1.ebuild,v 1.1 2002/04/22 20:05:19 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="the tftp server included in netkit"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/netkit-tftp-0.17.tar.gz"
HOMEPAGE="http://"

DEPEND="virtual/glibc"

src_compile() {
        cd ${S}
        ./configure --prefix=/usr --installroot=${D} || die
        emake
}

src_install() {
        mkdir -p ${D}/usr/bin ${D}/usr/sbin ${D}/usr/man/man1 ${D}/usr/man/man8
        cd ${S}
        make install
}


