# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bash/bash-2.04-r4.ebuild,v 1.4 2001/10/06 16:44:02 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The standard GNU Bourne again shell"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/bash/${P}.tar.gz ftp://ftp.gnu.org/gnu/bash/${P}.tar.gz"

HOMEPAGE="http://www.gnu.org/software/bash/bash.html"

DEPEND=">=sys-libs/ncurses-5.2-r2
        readline? ( >=sys-libs/readline-4.1-r2 )"
	
RDEPEND="virtual/glibc"

src_compile() {
    local myconf
    [ "`use readline`" ] && myconf="--with-installed-readline"
    [ -z "`use nls`" ] && myconf="${myconf} --disable-nls"
	./configure --prefix=/ --mandir=/usr/share/man --infodir=/usr/share/info --host=${CHOST} --disable-profiling --with-curses --enable-static-link ${myconf} || die
	emake || die
}

src_install() {
    make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
    dodir /bin
    mv ${D}/usr/bin/bash ${D}/bin
    dosym bash /bin/sh

    if [ -z "`use build`" ]
    then
	    doman doc/*.1

        if [ -z "`use readline`" ]
        then
          doman doc/*.3
        fi
	    dodoc README NEWS AUTHORS CHANGES COMPAT COPYING Y2K
	    dodoc doc/FAQ doc/INTRO

     else
        rm -rf ${D}/usr
     fi
}
