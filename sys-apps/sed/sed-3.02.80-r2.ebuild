# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sed/sed-3.02.80-r2.ebuild,v 1.3 2002/07/14 19:20:19 aliz Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Super-useful stream editor"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/sed/${A}"
HOMEPAGE="http://www.gnu.org/software/sed/sed.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
        myconf="--disable-nls"
    fi
	try ./configure --prefix=/usr --host=${CHOST} ${myconf}
    if [ -z "`use static`" ]
    then
	    try make ${MAKEOPTS}
    else
        try make ${MAKEOPTS} LDFLAGS=-static
    fi
}

src_install() {

    into /
	dobin sed/sed
	dodir /usr/bin
	dosym /bin/sed /usr/bin/sed

    if [ -z "`use build`" ]
    then
        into /usr
	    doinfo doc/sed.info
	    doman doc/sed.1
        dodoc COPYING NEWS README* THANKS TODO AUTHORS BUGS ANNOUNCE
    fi

}

