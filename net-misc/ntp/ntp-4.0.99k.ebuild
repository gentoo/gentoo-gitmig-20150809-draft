# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.0.99k.ebuild,v 1.1 2000/11/22 02:12:21 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Network Time Protocol suite/programs"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${A}"
HOMEPAGE="http://www.ntp.org/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {
    cd ${S}
    try make prefix=${D}/usr install

    dodoc ChangeLog INSTALL NEWS README TODO WHERE-TO-START

    cd ${S}/html
    docinto html
    dodoc *.htm

    cd ${S}/html/hints
    docinto html/hints
    dodoc *
    
    cd ${S}/html/pic
    docinto html/pic
    dodoc *

    cd ${S}/scripts
    insinto /usr/share/ntp
    doins *
}
