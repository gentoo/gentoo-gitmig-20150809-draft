# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgii/libgii-0.7.ebuild,v 1.1 2001/02/13 14:22:35 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
SRC_URI="ftp://ftp.ggi-project.org/pub/ggi/ggi/2_0_beta_3/${A}"
HOMEPAGE="http://www.ggi-project.org/"

DEPEND="virtual/glibc
        X? ( >=x11-base/xfree-4.0.2 )"

src_compile() {

    local myconf
    if [ -z "`use X`" ]
    then
      myconf="--without-x --disable-x --disable-xwin"
    fi

    try ./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    cd ${D}/usr/share/man/man3
    for i in *.3gii
    do
      mv ${i} ${i%.3gii}.3
    done
    cd ${S}
    dodoc ChangeLog* FAQ NEWS README
    docinto txt
    dodoc doc/*.txt
    docinto docbook
    dodoc doc/docbook/*.sgml

}

