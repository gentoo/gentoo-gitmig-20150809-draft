# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-3.33-r3.ebuild,v 1.1 2001/07/28 15:49:20 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Program to identify a file's format by scanning binary data for patters"
#unfortunately, this ftp site doesn't support passive ftp
#maybe we can find an alternative for those behind firewalls, or mirror
#on cvs.gentoo.org
SRC_URI="ftp://ftp.astron.com/pub/file/${A}"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --datadir=/usr/share/misc --host=${CHOST}
    if [ -z "`use static`" ]
    then
        try pmake
    else
        try pmake LDFLAGS=-static
    fi
}

src_install() {

	try make DESTDIR=${D} install
    if [ -z "`use build`" ] && [ -z "`use bootcd`" ]
    then
	    dodoc LEGAL.NOTICE MAINT README
    else
      rm -rf ${D}/usr/share/man
    fi

}



