# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/ed/ed-4-r1.ebuild,v 1.2 2000/08/16 04:37:53 drobbins Exp $

P=ed-4
A=ed.tar.Z
S=${WORKDIR}
DESCRIPTION="Line editor"
SRC_URI="ftp://ftp.metalab.unc.edu/pub/Linux/apps/editors/tty/"${A}

src_compile() {                           

    cp ed.c ed.c.orig
    sed -e "s:_cleanup();::" ed.c.orig > ed.c
    gcc $CFLAGS -o ed ed.c
 
}


src_install() {                              
    into /
    dobin ed
}




