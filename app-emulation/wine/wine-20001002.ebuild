# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20001002.ebuild,v 1.1 2000/10/26 15:02:06 achim Exp $

A=Wine-${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Wine is a free implementation of Windows on Unix."
SRC_URI="ftp://metalab.unc.edu/pub/Linux/ALPHA/wine/development/${A}"
HOMEPAGE="http://www.winehq.com"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --libdir=/usr/lib/wine --sysconfdir=/etc/wine \
	--host=${CHOST} --enable-opengl
    try make depend
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr libdir=${D}/usr/lib/wine install
    insinto /etc/wine
    doins ${FILESDIR}/wine.conf
    dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE
    dodoc README WARRANTY
}

