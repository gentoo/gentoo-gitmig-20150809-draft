# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Geert Bevin <gbevin@theleaf.be>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/daemontools/daemontools-0.76.ebuild,v 1.1 2001/12/05 02:29:27 gbevin Exp $


S=${WORKDIR}/admin/${P}
DESCRIPTION="Collection of tools for managing UNIX services"
SRC_URI="http://cr.yp.to/daemontools/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/daemontools.html"

DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}

    cd ${S}
    echo "gcc ${CFLAGS}" > src/conf-cc
    echo "gcc" > src/conf-ld
    echo ${S} > src/home

}

src_compile() {

    cd ${S}/src
    emake || die

}

src_install() {

    einfo "Creating service directory ..."
    dodir /service

    einfo "Installing package ..."
    cd ${S}/src
    exeinto /usr/bin
    for x in `cat ../package/commands`; do
        doexe $x
    done
    dodoc CHANGES ../package/README TODO

    einfo "Installing the svscan startup file ..."
    insinto /etc/init.d
    insopts -m755
    doins ${FILESDIR}/svscan

}



