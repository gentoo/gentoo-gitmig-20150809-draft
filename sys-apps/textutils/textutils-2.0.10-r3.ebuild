# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/textutils/textutils-2.0.10-r3.ebuild,v 1.1 2001/07/28 15:49:20 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU text utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
        myconf="--disable-nls"
    fi
	try ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
        --host=${CHOST} --build=${CHOST} --without-included-regex ${myconf}

    if [ -z "`use static`" ]
    then
	    try make ${MAKEOPTS}
    else
        try make ${MAKEOPTS} LDFLAGS=-static
    fi
}

src_install() {

	try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
	dodir /bin
    mv ${D}/usr/bin/cat ${D}/bin
	dosym /bin/cat /usr/bin/cat
	rmdir ${D}/usr/lib

    if [ -z "`use build`" ] && [ -z "`use bootcd`" ]
    then
        dodoc AUTHORS COPYING ChangeLog NEWS README* THANKS TODO
    else
        rm -rf ${D}/usr/share
    fi

}
