# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.19.3-r2.ebuild,v 1.2 2001/03/06 05:27:28 achim Exp $

P=gpm-1.19.3
A="${P}.tar.gz devfs.patch"
S=${WORKDIR}/${P}
DESCRIPTION="Console-based mouse driver"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/mouse/${A}
	 ftp://ftp.prosa.it/pub/gpm/patches/devfs.patch"

DEPEND="virtual/glibc
        tex? ( app-text/tetex )"

RDEPEND="virtual/glibc"

src_unpack() {

  unpack ${P}.tar.gz
  cd ${S}
  cp ${FILESDIR}/gpmInt.h .
  patch -p1 < ${DISTDIR}/devfs.patch

}

src_compile() {

    try ./configure --prefix=/usr --sysconfdir=/etc/gpm --without-curses
    # without-curses is required to avoid cyclic dependencies to ncurses
    cp Makefile Makefile.orig
    if [ -z "`use tex`" ]
    then
      sed -e "s/doc//" Makefile.orig > Makefile
    fi
    try make  ${MAKEOPTS}
}

src_install() {

    try make prefix=${D}/usr install

    chmod 755 ${D}/usr/lib/libgpm.so.1.18.0

    dodoc Announce COPYING ChangeLog FAQ MANIFEST README.*
    docinto txt
    dodoc doc/gpmdoc.txt

    if [ "`use tex`" ]
    then
      docinto ps
      dodoc doc/*.ps
    fi

    insinto /etc/gpm
    doins gpm-root.conf

}



