# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-www/amaya/amaya-4.1.ebuild,v 1.4 2001/06/03 09:54:22 achim Exp $

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

    try ../configure --prefix=/usr/X11R6 --host=${CHOST}
    try make

}

src_install () {

    dodir /usr/X11R6
    try make prefix=${D}/usr/X11R6 install
    rm ${D}/usr/X11R6/bin/amaya
    rm ${D}/usr/X11R6/bin/print
    dosym /usr/X11R6/Amaya/applis/bin/amaya /usr/X11R6/bin/amaya
    dosym /usr/X11R6/Amaya/applis/bin/print /usr/X11R6/bin/print
    dodoc README*

}

