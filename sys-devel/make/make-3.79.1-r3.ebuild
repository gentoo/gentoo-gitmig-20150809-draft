# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/make/make-3.79.1-r3.ebuild,v 1.1 2001/02/27 18:13:26 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard tool to compile source trees"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/make/${A}
	 ftp://prep.ai.mit.edu/gnu/make/${A}"
HOMEPAGE="http://www.gnu.org/software/make/make.html"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
        myconf="--disable-nls"
    fi
	try ./configure --prefix=/usr --mandir=/usr/share/man \
        --info=/usr/share/info --host=${CHOST} ${myconf}

    if [ -z "`use static`" ]
    then
	    try  make ${MAKEOPTS}
    else
        try  make ${MAKEOPTS} LDFLAGS=-static
    fi

}

src_install() {

    if [ -z "`use build`" ]
    then
	    try make DESTDIR=${D} install
	    dodoc AUTHORS COPYING ChangeLog NEWS README*
    else
        dobin make
    fi

}



