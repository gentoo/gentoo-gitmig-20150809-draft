# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/asapm/asapm-2.10.ebuild,v 1.2 2002/07/08 16:58:05 aliz Exp $

S=${WORKDIR}/${P}

DESCRIPTION="APM monitor for AfterStep"

SRC_URI="http://www.tigr.net/afterstep/download/asapm/asapm-2.10.tar.gz"

HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
LICENSE="GPL-2"

DEPEND="virtual/glibc virtual/x11"

src_compile() {
    ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff    
    emake || die
}

src_install () {

    dodir usr/bin
    dodir usr/share/man/man1
    
    make prefix=${D} install || die
}

