# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tcp-wrappers/tcp-wrappers-7.6-r2.ebuild,v 1.3 2002/07/14 19:20:19 aliz Exp $

A=tcp_wrappers_${PV}.tar.gz
A0="tcp_wrappers_${PV}.dif"
A1="tcp_wrappers_${PV}-ipv6-1.6.diff.gz"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="Freeware"
S=${WORKDIR}/tcp_wrappers_${PV}
DESCRIPTION="tcp wrappers"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${A}"

DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    cd ${S}/
    patch -p0 < ${FILESDIR}/${A0}
    gzip -dc ${FILESDIR}/${A1} | patch -p2
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" \
	-e "s:AUX_OBJ=.*:AUX_OBJ= \\\:" Makefile.orig > Makefile
}

src_compile() {                           

    try make ${MAKEOPTS} REAL_DAEMON_DIR=/usr/sbin linux
}

src_install() {

    dosbin tcpd tcpdchk tcpdmatch safe_finger try-from
    doman *.[358]
    dolib.a libwrap.a
    insinto /usr/include
    doins tcpd.h

    dodoc BLURB CHANGES DISCLAIMER README*
}





