# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/isapnptools/isapnptools-1.23.ebuild,v 1.2 2000/09/15 20:09:19 drobbins Exp $

P=isapnptools-1.23
A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Tools for configuring ISA PnP devices"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/hardware/${A}"
HOMEPAGE="http://www.roestock.demon.co.uk/isapnptools/"

src_compile() {  
    try ./configure --prefix=/usr --host=${CHOST}
    try make
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
    prepman
    dodoc AUTHORS ChangeLog COPYING README doc/README* doc/*.txt 
    dodoc etc/isapnp.*
}

