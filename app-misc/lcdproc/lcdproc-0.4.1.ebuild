# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp
# 20 Sept.2001 / 16.30 CET

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="lcdproc - displays system status on Matrix-Orbital 20x4 LCD on a serial port."
SRC_URI="http://lcdproc.omnipotent.net/${A}"
HOMEPAGE="http://lcdproc.omnipotent.net"

DEPEND=""

src_compile() {

    ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
    try make

}

src_install () {

    exeinto /usr/local/bin
    doexe server/LCDd
    doexe clients/lcdproc/lcdproc
    exeinto /etc/init.d
    doexe ${FILESDIR}/lcdproc
    doman docs/lcdproc.1
    dodoc README ChangeLog COPYING INSTALL 
    docinto docs
    dodoc docs/README.dg docs/README.dg2 docs/hd44780_howto.txt docs/menustuff.txt docs/netstuff.txt 
    docinto clients/example
    dodoc clients/examples/fortune.pl clients/examples/iosock.pl clients/examples/tail.pl clients/examples/x11amp.pl 
    docinto clients/headlines
    dodoc clients/headlines/lcdheadlines
}

pkg_postinst () {

    cp -s /etc/init.d/lcdproc /etc/runlevels/default/lcdproc
}

pkg_postrm () {

    rm -f /etc/runlevels/default/lcdproc
}