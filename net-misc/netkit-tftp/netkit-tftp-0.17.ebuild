# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-tftp/netkit-tftp-0.17.ebuild,v 1.5 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="the tftp server included in netkit"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/netkit-tftp-0.17.tar.gz"
HOMEPAGE="http://"
KEYWORDS="x86 sparc sparc64"
LICENSE="bsd"
SLOT="0"

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


