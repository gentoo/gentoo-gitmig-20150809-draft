# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/which/which-2.11-r1.ebuild,v 1.4 2000/10/03 16:02:06 achim Exp $

P=which-2.11
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Prints out location of specified executables that are in your path"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/which/${A}
	 ftp://prep.ai.mit.edu/gnu/which/${A}"

src_compile() {                           
    try ./configure --prefix=/usr
    try make
}

src_unpack() {
    unpack ${A}
    cd ${S}/tilde
    cp shell.c shell.c.orig
    echo "#define NULL ( 0L )" > shell.c
    cat shell.c.orig >> shell.c
}

src_install() {                               
    into /usr
    dobin which
    doman which.1
    doinfo which.info
    dodoc AUTHORS COPYING EXAMPLES NEWS README*
}

