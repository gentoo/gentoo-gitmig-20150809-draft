# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/isapnptools/isapnptools-1.23.ebuild,v 1.3 2000/11/30 23:14:33 achim Exp $

P=isapnptools-1.23
A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Tools for configuring ISA PnP devices"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/hardware/${A}"
HOMEPAGE="http://www.roestock.demon.co.uk/isapnptools/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {  
    try ./configure --prefix=/usr --host=${CHOST}
    try make ${MAKEOPTS}
} 

src_unpack() {
    unpack ${A}
    cd ${S}/src
    cp pnpdump_main.c pnpdump_main.c.orig
    sed -e "s/^static FILE\* o_file.*//" \
	-e "s/o_file/stdout/g" \
	-e "s/stdout_name/o_file_name/g" pnpdump_main.c.orig > pnpdump_main.c
#    cp Makefile Makefile.orig
#    sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile

}

src_install() {                               
    cd ${S}
    dodir /usr/man/man5 
    dodir /usr/man/man8
    try make DESTDIR=${D} install
    dodoc AUTHORS ChangeLog COPYING README NEWS 
    docinto txt
    # Small fix
    dodoc doc/README*  doc/*.txt test/*.txt
    dodoc etc/isapnp.*
}

