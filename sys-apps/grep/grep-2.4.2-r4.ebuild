# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.4.2-r4.ebuild,v 1.1 2001/07/28 15:49:20 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU regular expression matcher"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/grep/${A}
	 ftp://prep.ai.mit.edu/gnu/grep/${A}"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
      myconf="--disable-nls"
    fi
	try ./configure --prefix=/usr --mandir=/usr/share/man \
        --infodir=/usr/share/info --host=${CHOST} ${myconf}

    if [ -z "`use static`" ]
    then
	    try make ${MAKEOPTS}
    else
        try make LDFLAGS=-static ${MAKEOPTS}
    fi
}

src_install() {

    try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
    
    if [ -z "`use build`" ] && [ -z "`use bootcd`" ]
    then
        dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO
    else
        rm -rf ${D}/usr/share
    fi

}



