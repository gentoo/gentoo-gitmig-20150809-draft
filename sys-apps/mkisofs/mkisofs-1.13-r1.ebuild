# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mkisofs/mkisofs-1.13-r1.ebuild,v 1.2 2000/08/16 04:38:28 drobbins Exp $

P=mkisofs-1.13
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Prints out location of specified executables that are in your path"
SRC_URI="ftp://ftp.fokus.gmd.de/pub/unix/cdrecord/mkisofs/$A"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/mkisofs.html"

src_compile() {                           
    make
}

src_install() {                               
    into /usr
    dobin mkisofs/OBJ/i686-linux-cc/mkisofs
    dobin mkisofs/diag/OBJ/i686-linux-cc/devdump
    dobin mkisofs/diag/OBJ/i686-linux-cc/isodump
    dobin mkisofs/diag/OBJ/i686-linux-cc/isoinfo
    dobin mkisofs/diag/OBJ/i686-linux-cc/isovfy
    doman mkisofs/mkisofs.8 mkisofs/mkhybrid.8 mkisofs/apple_driver.8
    doman mkisofs/diag/isoinfo.8
    dodoc ABOUT BUILD COMPILE COPYING MKNOD* PORTING README*
    docinto mkisofs
    dodoc mkisofs/ChangeLog
    dodoc mkisofs/README* mkisofs/TODO
}


