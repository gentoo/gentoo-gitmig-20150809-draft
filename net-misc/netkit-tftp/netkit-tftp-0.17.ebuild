# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Travis Tilley <lordviram@nesit.org>

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
        mkdir -p ${D}/usr/bin ${D}/usr/sbin ${D}/usr/share/man/man1 ${D}/usr/share//man/man8
        cd ${S}
        make install
}


