# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.10.38.ebuild,v 1.2 2001/06/18 12:24:00 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU locale utilities"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gettext/${A}
	 ftp://prep.ai.mit.edu/gnu/gettext/${A}"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"

if [ -z "`use build`" ] ; then
DEPEND="virtual/glibc"
fi

src_compile() {
    local myconf
    if [  -z "`use nls`" ]
    then
        myconf="--disable-nls"
    fi 
    try ./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man \
                --with-included-gettext --disable-shared --host=${CHOST} ${myconf}
    try make ${MAKEOPTS}
}

src_install() {

        try make prefix=${D}/usr infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
                lispdir=${D}/usr/share/emacs/site-lisp install

	dodoc AUTHORS BUGS COPYING ChangeLog DISCLAIM NEWS README* THANKS TODO

        exeopts -m0755
	exeinto /usr/bin
	doexe misc/gettextize
}


