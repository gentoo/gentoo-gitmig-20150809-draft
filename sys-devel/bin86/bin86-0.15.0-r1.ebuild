# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.15.0-r1.ebuild,v 1.2 2000/08/16 04:38:33 drobbins Exp $

P=bin86-0.15.0
A=${P}.tar.gz
S=${WORKDIR}/bin86
DESCRIPTION="Assembler and loader used to create kernel bootsector"
SRC_URI="http://www.cix.co.uk/~mayday/${A}"
HOMEPAGE="http://www.cix.co.uk/~mayday/"

src_compile() {                           
	make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s/CFLAGS=-O2/CFLAGS=${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
    into /usr
    dobin as/as86 as/as86_encap ld/ld86 ld/objdump86 ld/catimage ld/objchop
    dosym objdump86 /usr/bin/nm86
    dosym objdump86 /usr/bin/size86
    doman man/*.1
    dosym as86_encap.1.gz /usr/man/man1/as86_encap.1.gz
    dodoc README README-0.4 ChangeLog as/COPYING as/TODO
}


