# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.1-r2.ebuild,v 1.2 2001/08/04 18:22:45 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"

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
        --infodir=/usr/share/info --bindir=/bin ${myconf}
    if [ -z "`use static`" ]
    then
	    try make ${MAKEOPTS}
    else
        try make ${MAKEOPTS} LDFLAGS=-static
    fi
}

src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info bindir=${D}/bin install
	cd ${D}
	dodir /usr/bin
	rm -rf usr/lib
	cd usr/bin
	ln -s ../../bin/* .
	if [ -z "`use bootcd`" ] && [ -z "`use build`" ]
	then
		cd ${S}
		dodoc COPYING NEWS README*  THANKS TODO ChangeLog ChangeLog-1997 AUTHORS
	else
		rm -rf ${D}/usr/share
	fi

}

