# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bash/bash-2.05.ebuild,v 1.2 2001/09/15 19:29:14 danarmak Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The standard GNU Bourne again shell"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/bash/${A}
	 ftp://ftp.gnu.org/gnu/bash/${A}"

HOMEPAGE="http://www.gnu.org/software/bash/bash.html"

DEPEND=">=sys-libs/ncurses-5.2-r2
        readline? ( >=sys-libs/readline-4.2 )"
#        tex? ( app-text/tetex )

RDEPEND="virtual/glibc"

src_compile() {

    local myconf
    if [ "`use readline`" ]
    then
        myconf="--with-installed-readline"
    fi

    if [ -z "`use nls`" ]
    then
        myconf="${myconf} --disable-nls"
    fi

	try ./configure --prefix=/  --mandir=/usr/share/man \
        --infodir=/usr/share/info --host=${CHOST} \
        --disable-profiling --with-curses \
        --enable-static-link ${myconf}

    try pmake

	if [ "`use tex`" ] && [ -z "`use build`" ]
	then
        cd support
        cp texi2html texi2html.orig
        sed -e "s:/usr/local/bin/perl:/usr/bin/perl:" \
        texi2html.orig > texi2html
        cd ../doc
        try make
	fi

}



src_install() {

    make prefix=${D}/usr mandir=${D}/usr/share/man \
    infodir=${D}/usr/share/info install
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

        if [ "`use tex`" ]
        then
	        docinto html
	        dodoc doc/*.html
	        docinto ps
	        dodoc doc/*.ps
	    fi
     else
        rm -rf ${D}/usr
     fi

}

