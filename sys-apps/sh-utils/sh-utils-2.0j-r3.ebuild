
# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sh-utils/sh-utils-2.0j-r3.ebuild,v 1.3 2001/08/11 05:30:57 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Your standard GNU shell utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_unpack() {

  unpack ${A}
  cd ${S}
  patch -p0 < ${FILESDIR}/${P}-src-sys2.h-gentoo.diff
}

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
        myconf="--disable-nls"
    fi

	try CFLAGS="${CFLAGS}" ./configure --host=${CHOST} --build=${CHOST} \
        --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
        --without-included-regex ${myconf}

    if [ -z "`use static`" ]
    then
	    try make ${MAKEOPTS}
    else
        try make ${MAKEOPTS} LDFLAGS=-static
    fi
}

src_install() {

	try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
	rm -rf ${D}/usr/lib
	dodir /bin
    cd ${D}/usr/bin
    mv date echo false pwd stty su true uname ${D}/bin

    if [ -z "`use build`" ]
    then
	    # We must use hostname from net-base
	    rm hostname
        cd ${S}
	    dodoc AUTHORS COPYING ChangeLog ChangeLog.0 \
	      NEWS README THANKS TODO
    else
       rm -rf ${D}/usr/lib ${D}/usr/share/man ${D}/usr/share/info
    fi

}



