# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/debianutils/debianutils-1.13.3-r3.ebuild,v 1.1 2001/02/27 16:22:11 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A selection of tools from Debian"
SRC_URI="ftp://ftp.debian.org/debian/dists/potato/main/source/base/debianutils_${PV}.tar.gz"

DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff

}

src_compile() {

    if [ -z "`use static`" ]
    then
	    try pmake
    else
        try pmake LDFLAGS=-static
    fi
}


src_install() {

	into /
	dobin readlink tempfile mktemp

    if [ -z "`use build`" ]
    then
        dobin run-parts
	    insopts -m755
	    exeinto /usr/sbin
	    doexe savelog

	    doman mktemp.1 readlink.1 tempfile.1 run-parts.8 savelog.8

        cd debian
	    dodoc changelog control copyright
    fi

}



