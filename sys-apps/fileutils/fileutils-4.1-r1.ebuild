# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.1-r1.ebuild,v 1.1 2001/04/30 18:00:35 achim Exp $

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

    if [ -z "`use build`" ]
    then
	    make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info bindir=${D}/bin install
	    cd ${D}
        dodir /usr/bin
        rm -rf usr/lib
        cd usr/bin
        ln -s ../../bin/* .
        cd ${S}
        dodoc COPYING NEWS README*  THANKS TODO ChangeLog ChangeLog-1997 AUTHORS
     else
        cd ${S}/src
	    into /
        dobin  chgrp chown dd dir du ln mkdir mknod rm touch \
               chmod cp df ls mkfifo mv rmdir sync
        newbin ginstall install
        dosym /bin/install /usr/bin/install
     fi

}

