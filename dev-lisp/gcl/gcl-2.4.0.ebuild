# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.4.0.ebuild,v 1.3 2001/08/31 03:23:38 pm Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Common Lisp"
SRC_URI="ftp://rene.ma.utexas.edu/pub/gcl/gcl-2.4.0.tgz"

PROVIDE="virtual/commonlisp"

src_compile() {

    cd ${S} ;  echo `pwd`
    try ./configure --prefix=/usr

    for i in */makefile makedefs makedefc makefile config.status ; do 
	mv $i $i.orig ;
	cat $i.orig | sed -e 's:./configure\: emacs\: command not found:${prefix}/share/emacs/site-lisp/gcl:g' > $i
    done

    cd ${S}
    try make ${MAKEOPTS}

}

src_install() {

    dodir /usr/share/info
    dodir /usr/share/emacs/site-lisp/gcl

    try make install prefix=${D}/usr MANDIR=${D}/usr/share/man

    mv ${D}/usr/lib/${P}/info/* ${D}/usr/share/info
    rm ${D}/usr/share/info/texinfo.tex
    rm ${D}/usr/share/emacs/site-lisp/gcl/default.el

    mv ${D}/usr/bin/gcl ${D}/usr/bin/gcl.orig
    sed -e "s:${D}::g" < ${D}/usr/bin/gcl.orig > ${D}/usr/bin/gcl
    rm ${D}/usr/bin/gcl.orig

    chmod 0755 ${D}/usr/bin/gcl
}
