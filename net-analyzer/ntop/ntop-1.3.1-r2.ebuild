# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-1.3.1-r2.ebuild,v 1.1 2000/11/14 17:11:17 achim Exp $

P=ntop-1.3.1
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Unix Tool that shows networkusage like top"
SRC_URI="ftp://ftp.it.ntop.org/pub/local/ntop/snapshots/${A}"
HOMEPAGE="http://www.ntop.org/ntop.html"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=dev-libs/openssl-0.9.6
	>=net-libs/libpcap-0.5.2"

src_unpack() {
    unpack ${A}
    if [ -n "`use glibc22`" ]
    then
	echo "Using glibc-2.2"
	cp ${FILESDIR}/main.c ${S}/main.c
    fi
}
src_compile() {
    cd ${S}
    cp configure configure.orig
    sed -e "s:/usr/local/ssl:/usr:" configure.orig > configure
    CFLAGS="$CFLAGS -I/usr/include/openssl" try ./configure --prefix=/usr --sysconfdir=/usr/share --host=${CHOST} 
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr sysconfdir=/${D}/usr/share install
    mv ${D}/usr/bin/plugins ${D}/usr/share/ntop
    prepman
    dodoc AUTHORS ChangeLog CONTENTS COPYING FAQ FILES HACKING
    dodoc KNOWN_BUGS MANIFESTO NEWS ntop.txt PORTING README*
    dodoc SUPPORT* THANKS THREADS-FAQ TODO
    docinto html
    dodoc ntop.html
}



