# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bzip2/bzip2-1.0.1-r4.ebuild,v 1.1 2001/08/04 18:22:45 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A high-quality data compressor used extensively by Gentoo"
SRC_URI="ftp://sourceware.cygnus.com/pub/bzip2/v100/${A}
	 ftp://ftp.freesoftware.com/pub/sourceware/bzip2/v100/${A}"

HOMEPAGE="http://sourceware.cygnus.com/bzip2/"

DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}

    cd ${S}
    patch -p0 < ${FILESDIR}/bzip2-1.0.1-Makefile-gentoo.diff
    cp ${FILESDIR}/Makefile.dietlibc .
}

src_compile() {
    if [ -z "`use build`" ] && [ -z "`use bootcd`" ]
    then
	    try pmake -f Makefile-libbz2_so all
    fi
    if [ -z "`use static`" ]
    then
	    try pmake all
    else
		if [ "`use diet`" ]
		then
			try pmake LDFLAGS=-static -f Makefile.dietlibc all
		else
            try pmake LDFLAGS=-static all
		fi
    fi
}
src_install() {

    if [ -z "`use build`" ]
    then
	    try make DESTDIR=${D} install
	    mv ${D}/usr/bin ${D}
		
		if [ -z "`use bootcd`" ]
		then
			try make DESTDIR=${D} -f Makefile-libbz2_so install
			
			dodoc README LICENSE CHANGES Y2K_INFO
			docinto txt
			dodoc bzip2.txt
			docinto ps
			dodoc manual.ps
			docinto html
			dodoc manual_*.html
		else
			rm -rf ${D}/usr
		fi
	else
        into /
        dobin bzip2
        cd ${D}/bin
        ln -s bzip2 bunzip2        
     fi

}


