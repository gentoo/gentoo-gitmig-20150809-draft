# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/dnd/dnd-1.1.ebuild,v 1.1 2001/09/27 22:12:43 karltk Exp $

S=${WORKDIR}/DND/DNDlib

DESCRIPTION="OffiX' Drag'n'drop library"

SRC_URI="http://leb.net/OffiX/dnd.1.1.tgz"

HOMEPAGE="http://leb.net/OffiX"

DEPEND="virtual/glibc virtual/x11"

src_unpack() {

    unpack dnd.1.1.tgz
    cd ${S}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
      
}

src_compile() {
    ./configure --infodir=/usr/share/info \
                --mandir=/usr/share/man \
                --prefix=/usr \
                --with-x \
                --host=${CHOST} || die
    emake || die
}

src_install () {

    make prefix=${D}/usr install || die

}

