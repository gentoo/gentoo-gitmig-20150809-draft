# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-2.0.7-r4.ebuild,v 1.1 2001/08/04 18:22:45 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools"
SRC_URI="ftp://people.redhat.com/johnsonm/procps/${A}"
RDEPEND=">=sys-libs/ncurses-5.2-r2"
DEPEND="${RDEPEND}
        >=sys-devel/gettext-0.10.35"

src_unpack() {

    unpack ${A}

    cd ${S}
    patch -p1 < ${FILESDIR}/${P}.diff

    mv Makefile Makefile.orig
    sed -e "s/-O3/${CFLAGS}/" -e 's/all: config/all: /' \
	-e "s:--strip::" -e 's:/usr/man:/usr/share/man:' Makefile.orig > Makefile

    cd ${S}/ps
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" -e "s:--strip::" -e 's:/usr/man:/usr/share/man:' Makefile.orig > Makefile

    cd ${S}/proc
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" -e "s:--strip::" -e 's:/usr/man:/usr/share/man:'  Makefile.orig > Makefile

}

src_compile() {
	try make ${MAKEOPTS}
}

src_install() {

    dodir /usr/bin
    dodir /sbin
    dodir /usr/X11R6/bin
    dodir /usr/share/man/man{1,5,8}
    dodir /lib
    dodir /bin
    try make DESTDIR=${D} MANDIR=/usr/share/man install

    preplib /
	
	if [ -z "`use bootcd`" ]
	then
		dodoc BUGS COPYING COPYING.LIB NEWS TODO
		docinto proc
		dodoc proc/COPYING
		docinto ps
		dodoc ps/COPYING ps/HACKING
	else
		rm -rf ${D}/usr/X11R6 ${D}/usr/share
	fi
}



