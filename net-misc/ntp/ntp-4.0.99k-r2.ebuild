# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.0.99k-r2.ebuild,v 1.2 2001/05/28 14:32:32 achim Exp $

A=${P}23.tar.gz
S=${WORKDIR}/${P}23
DESCRIPTION="Network Time Protocol suite/programs"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${A}"
HOMEPAGE="http://www.ntp.org/"

DEPEND="virtual/glibc
	>=sys-libs/readline-4.1"

src_unpack() {
    unpack ${A}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    cp configure configure.orig
    sed -e "s:-Wpointer-arith::" configure.orig > configure

    try LDFLAGS=\"$LDFLAGS -lncurses\" ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} --build=${CHOST}
    try make
}

src_install () {
    try make prefix=${D}/usr mandir=${D}/usr/share/man install

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
