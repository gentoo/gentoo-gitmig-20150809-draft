# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake/automake-1.4-r1.ebuild,v 1.2 2000/08/16 04:38:32 drobbins Exp $

P=automake-1.4      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Used to generate Makefile.in from Makefile.am"
SRC_URI="ftp://prep.ai.mit.edu/gnu/automake/${A}"
HOMEPAGE="http://www.gnu.org/software/automake/automake.html"

src_compile() {                           
    ./configure --prefix=/usr --host=${CHOST}
    make
}

src_install() {                               
    into /usr
    insinto /usr/bin
    dodir /usr/bin
    insopts -m0755
    doins aclocal automake
    insopts -m0644
    dodir /usr/info
    doinfo *.info*
    dodir /usr/share/aclocal
    insinto /usr/share/aclocal
    doins m4/*.m4
    dodir /usr/share/automake
    insinto /usr/share/automake
    doins *.am COPYING INSTALL ansi2knr.* texinfo.tex
    rm ${D}/usr/share/automake/Makefile.am
    insopts -m0755
    doins acinstall config.guess config.sub elisp-comp install-sh mdate-sh
    doins missing mkinstalldirs ylwrap
    dodoc COPYING NEWS README THANKS TODO AUTHORS ChangeLog
}


