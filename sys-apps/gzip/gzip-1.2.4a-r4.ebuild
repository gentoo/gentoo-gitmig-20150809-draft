# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gzip/gzip-1.2.4a-r4.ebuild,v 1.1 2001/07/28 15:49:20 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU compressor"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gzip/${A}
	 ftp://prep.ai.mit.edu/gnu/gzip/${A}"
HOMEPAGE="http://www.gnu.org/software/gzip/gzip.html"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
        myconf="--disable-nls"
    fi

	try ./configure --host=${CHOST} --prefix=/usr --exec-prefix=/ \
        --mandir=/usr/share/man --infodir=/usr/share/info ${myconf}

    if [ -z "`use static`" ]
    then
	    try pmake
    else
        try pmake LDFLAGS=-static ${MAKEOPTS}
    fi
}

src_install() {

    dodir /usr/bin /usr/share/man/man1
	try make prefix=${D}/usr exec_prefix=${D}/ mandir=${D}/usr/share/man/man1 infodir=${D}/usr/share/info install

	cd ${D}/bin
	for i in gzexe zforce zgrep zmore znew zcmp
	do
	  cp ${i} ${i}.orig
	  sed -e "1d" -e "s:${D}::" ${i}.orig > ${i}
	  rm ${i}.orig
	  chmod 755 ${i}
	done

    if [ -z "`use build`" ] && [ -z "`use bootcd`" ]
    then
        cd ${D}/usr/share/man/man1

	    for i in gzexe gzip zcat zcmp zdiff zforce \
	        zgrep zmore znew
	    do
	        rm ${i}.1
	        ln -s gunzip.1.gz ${i}.1.gz
	    done

	    cd ${S}
	    rm -rf ${D}/usr/man ${D}/usr/lib

	    dodoc ChangeLog COPYING NEWS README THANKS TODO
	    docinto txt
	    dodoc algorithm.doc gzip.doc
    else
        rm -rf ${D}/usr
    fi
}




