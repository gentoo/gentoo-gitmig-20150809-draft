# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4o-r2.ebuild,v 1.9 2002/08/14 11:56:44 murphy Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU macro processor"
SRC_URI="ftp://ftp.seindal.dk/gnu/${A}"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )
        >=sys-devel/libtool-1.3.5-r2"

RDEPEND="virtual/glibc"

src_compile() {
    local myconf
    if [ -z "`use nls`" ]
    then
        myconf="--disable-nls"
    fi
    try ./configure --prefix=/usr --libexecdir=/usr/lib \
        --mandir=/usr/share/man --infodir=/usr/share/info \
        --with-modules --host=${CHOST} ${myconf}
    try make ${MAKEOPTS}
}

src_install() {

    cd ${S}

    try make prefix=${D}/usr libexecdir=${D}/usr/lib \
        mandir=${D}/usr/share/man infodir=${D}/usr/share/info install

    rm -rf ${D}/usr/include

    dodoc AUTHORS BACKLOG ChangeLog COPYING NEWS README* THANKS TODO
    docinto modules
    dodoc modules/README modules/TODO
    docinto html
    dodoc examples/WWW/*.htm

}


