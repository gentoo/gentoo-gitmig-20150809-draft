# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-www/amaya/amaya-4.1-r1.ebuild,v 1.1 2001/10/06 11:33:58 verwilst Exp $

#P=
A=${PN}-src-${PV}.tgz
S=${WORKDIR}/Amaya/LINUX-ELF
DESCRIPTION="The W3C Web-Browser"
SRC_URI="ftp://ftp.w3.org/pub/amaya/${PN}-src-${PV}.tgz"
HOMEPAGE="http://www.w3.org/Amaya/"

DEPEND=">=x11-libs/openmotif-2.1.30 sys-devel/perl"
RDEPEND=">=x11-libs/openmotif-2.1.30"

src_compile() {

    mkdir ${S}
    cd ${S}

    try ../configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    dodir /usr
    try make prefix=${D}/usr install
    rm ${D}/usr/bin/amaya
    rm ${D}/usr/bin/print
    dosym /usr/Amaya/applis/bin/amaya /usr/bin/amaya
    dosym /usr/Amaya/applis/bin/print /usr/bin/print
    
}

